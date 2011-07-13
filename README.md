# riot-datamapper #

Riot assertion macros for datamapper.

[Riot](https://github.com/thumblemonks/riot) is a fast, expressive, and contextual ruby unit testing framework.

[DataMapper](http://datamapper.org/) is an ORM which is fast, thread-safe and feature rich.

These macros provide an easy way to test some properties of your
DataMapper models.

## Installation ##

Install it via rubygems:

```
gem install riot-datamapper
```

Or stick it in your Gemfile:

```ruby
# Gemfile

group :test do
  gem 'riot-datamapper'
end
```

## Examples / Usage ##

Given a model like:

```ruby
# foo_bar.rb

class FooBar
  include DataMapper::Resource

  property :foo,    String
  property :bar,    Serial
  property :monkey, Boolean, :default => false
  property :name,   String,  :default => 'monkey', :required => true
end
```

You can test this like so:

```ruby
# foo_bar_test.rb

context "FooBar Model" do
  setup { FooBar }

  asserts_topic.has_property :foo
  asserts_topic.has_property :bar,    'Serial'
  asserts_topic.has_property :monkey, 'Boolean', :default => false
  asserts_topic.has_property :name,   'String',  :default => 'monkey', :required => true
end
```

### TODO ###

* Add more macros
* Add validation macros so you can do something like #has_validation :validates_presence_of

## Copyright

Copyright © 2011 Arthur Chiu. See [MIT-LICENSE](https://github.com/achiu/riot-datamapper/blob/master/MIT-LICENSE) for details.



