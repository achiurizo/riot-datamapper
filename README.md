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

class User
  include DataMapper::Resource

  property :foo,    String
  property :bar,    Serial
  property :buzz,   Integer
  property :monkey, Boolean, :default => false
  property :name,   String,  :default => 'monkey', :required => true

  has n, :comments, :through => :posts
  has 1, :address

  validates_presence_of  :foo
  validates_uniquness_of :bar
  validates_length_of    :buzz, :maximum => 20
end

class Address
  property :street, String
  property :city,   String

  belongs_to :user
end

class Comment

  property :title, String
  property :body,  Text

  belongs_to :post
  belongs_to :user, :required => false
end


class Post

  property :title, String
  property :body,  Text

  has n, :comments
end
```

You can test this like so:

```ruby
# foo_bar_test.rb

context "User Model" do
  setup { User }

  asserts_topic.has_property :foo
  asserts_topic.has_property :bar,    'Serial'
  asserts_topic.has_property :monkey, 'Boolean', :default => false
  asserts_topic.has_property :name,   'String',  :default => 'monkey', :required => true

  asserts_topic.has_association :has_n, :comments, :through => :posts
  asserts_topic.has_association :has 1, :address

  asserts_topic.has_validation :validates_presence_of,  :foo
  asserts_topic.has_validation :validates_uniquness_of, :bar
  asserts_topic.has_validation :validates_length_of,    :buzz, :maximum => 20
end

context "Address Model" do
  setup { Address }

  asserts_topic.has_property :street, 'String'
  asserts_topic.has_property :city,   'String'

  asserts_topic.has_association :belongs_to, :user
end

context "Comment Model" do
  setup { Comment }

  asserts_topic.has_property :title, 'String'
  asserts_topic.has_property :body,  'Text'

  asserts_topic.has_association :belongs_to, :post
  asserts_topic.has_association :belongs_to, :user, :required => false
end

context "Post Model" do
  setup { Post }

  asserts_topic.has_property :title, 'String'
  asserts_topic.has_property :body,  'Text'


  asserts_topic.has_association :has_n, :comments
end
```

## Copyright

Copyright © 2011 Arthur Chiu. See [MIT-LICENSE](https://github.com/achiu/riot-datamapper/blob/master/MIT-LICENSE) for details.



