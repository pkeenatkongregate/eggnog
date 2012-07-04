class Eggnog::NodeDecorator < Struct.new(:node, :options)

  CONTENT_ROOT = "__content__".freeze

  def self.to_hash(node, options = {})
    new(node, options).to_hash
  end

  def to_hash(parent_hash = {})
    insert_into_parent_hash(parent_hash, collect_nodes)
  end

  private

  def insert_into_parent_hash(hash, content)
    case hash[name]
    when NilClass then hash[name] = content
    when Hash     then hash[name] = [hash[name], content]
    when Array    then hash[name] << content
    end
    hash
  end

  def collect_nodes
    case node
    when Nokogiri::XML::Document
      self.class.to_hash(node.root, options)
    else
      if preserve_attributes?
        output = collect_attributes

        if output.empty?
          output = collect_children
        else
          output[CONTENT_ROOT] = collect_children
        end

        output
      else
        collect_children
      end
    end
  end

  def collect_attributes
    ({}).tap do |output|
      attribute_nodes.each {|a| output[a.name] = a.value }
    end
  end

  def collect_children
    if element_children.empty?
      self.content
    else
      output = {}

      element_children.each do |child|
        child.to_hash(output)
      end

      output
    end
  end

  def element_children
    @element_children ||= node.element_children.map {|c| self.class.new(c, options)}
  end

  def preserve_attributes?
    !!options.fetch(:preserve_attributes) { false }
  end

  def method_missing(m, *args, &block)
    node.send(m, *args, &block)
  end

end
