require "ox"
require File.expand_path("../ox/node", __FILE__)
require File.expand_path("../ox/builder", __FILE__)

module Eggnog
  class XML
    class Builder
      include ::Eggnog::Ox::Builder
    end
  end
end
