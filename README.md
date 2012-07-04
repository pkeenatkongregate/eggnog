Eggnog
======

[![travis](https://secure.travis-ci.org/rclosner/eggnog.png)](http://travis-ci.org/rclosner/eggnog)

<img src="https://github.com/rclosner/eggnog/raw/master/eggnog.jpg" width="200px" />

Eggnog is a Nokogiri XML Node Class mixin that implements Node#to_hash

Installation
============

  gem install eggnog

Usage
=====

##XML

```ruby
  xml =<<DOC
  <root>
    <foo bar='baz'>Some text value</foo>
  </root>
  DOC
```
    
```ruby
  node = Nokogiri::XML(xml)
```

```ruby
  node.to_hash
```

returns:

```ruby
  {
    "root" => {
      "foo" => "Some text value" 
    } 
  }
```

Preserve XML attributes:

```ruby
  node.to_hash(:preserve_attributes => true)
```
returns

```ruby
  { 
    "root" => {
      "foo" => { 
        "__content__" => "Some text value", 
        "bar" => "baz" 
      } 
    } 
  }
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
