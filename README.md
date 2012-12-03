#Eggnog

[![travis](https://secure.travis-ci.org/rclosner/eggnog.png)](http://travis-ci.org/rclosner/eggnog)

<img src="https://github.com/rclosner/eggnog/raw/master/eggnog.jpg" width="200px" />

A fast XML and JSON parser.

## Installation

```ruby
  gem install eggnog
```

## Usage


# XML


Easily parse the following XML:
```
  xml =<<DOC
  <?xml version="1.0"?>
  <foo>
    <bar baz="boo">Some text value</bar>
  </foo>
  DOC
```

like this:
```ruby
Eggnog::XML.parse(xml)
```

which returns:
```ruby
  {
    "foo" => {
      "bar" => "Some text value"
    }
  }
```

# Additional Options

Preserve XML attributes:

```ruby
  Eggnog::XML.parse(xml, :preserve_attributes => true)
```
returns:

```ruby
  { 
    "foo" => {
      "bar" => { 
        "__content__" => "Some text value", 
        "baz" => "boo" 
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
