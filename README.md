#Eggnog

[![travis](https://secure.travis-ci.org/rclosner/eggnog.png)](http://travis-ci.org/rclosner/eggnog)

<img src="https://github.com/rclosner/eggnog/raw/master/eggnog.jpg" width="200px" />

Eggnog makes parsing XML easy 

## Installation

```ruby
  gem install eggnog
```

## Usage


# XML


```
  <root>
    <foo bar='baz'>Some text value</foo>
  </root>
```
returns:

```ruby
  {
    "root" => {
      "foo" => "Some text value"
    }
  }

# With Options

Preserve XML attributes:

```ruby
  Eggnog::Xml.parse(xml, :preserve_attributes => true)
```
returns:

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
