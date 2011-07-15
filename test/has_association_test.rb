require File.expand_path('../teststrap', __FILE__)

context "has_association macro" do
  setup do
    Object.send(:remove_const, :Post)    if Object.const_defined?(:Post)
    Object.send(:remove_const, :User)    if Object.const_defined?(:User)
    Object.send(:remove_const, :Comment) if Object.const_defined?(:Comment)

    class Post
      include DataMapper::Resource

      property :id,  Serial
      property :foo, String

      has n, :comments
      has n, :users, :through => :comments
    end

    class User
      include DataMapper::Resource

      property :id, Serial
      has 1, :comment
    end

    class Comment
      include DataMapper::Resource
      property :id,  Serial

      belongs_to :user
      belongs_to :post
    end
    DataMapper.finalize
  end

  asserts "that it passes when the model has n :comments" do
    Riot::DataMapper::HasAssociation.new.evaluate(Post,:has_n, :comments).first
  end.equals :pass

  asserts "that it fails when the model does not has n :foos" do
    Riot::DataMapper::HasAssociation.new.evaluate(Post,:has_n, :foos).first
  end.equals :fail

  asserts "that it passes when the model has n :users, :through => :comments" do
    Riot::DataMapper::HasAssociation.new.evaluate(Post,:has_n, :users, :through => :comments).first
  end.equals :pass

  asserts "that it fails when the model does not has n :users, :through => :bubbles" do
    Riot::DataMapper::HasAssociation.new.evaluate(Post,:has_n, :users, :through => :bubbles).first
  end.equals :fail

  asserts "that it passes when the model belongs_to :post" do
    Riot::DataMapper::HasAssociation.new.evaluate(Comment, :belongs_to, :post).first
  end.equals :pass

  asserts "that it fails when the model does not belongs_to :foo" do
    Riot::DataMapper::HasAssociation.new.evaluate(Comment, :belongs_to, :foo).first
  end.equals :fail

  asserts "that it passes when the model has 1 :comment" do
    Riot::DataMapper::HasAssociation.new.evaluate(User, :has_1, :comment).first
  end.equals :pass

  asserts "that it passes when the model does not has 1 :foo" do
    Riot::DataMapper::HasAssociation.new.evaluate(User, :has_1, :foo).first
  end.equals :fail

  asserts "that it passes when the model belongs_to :user" do
    Riot::DataMapper::HasAssociation.new.evaluate(Comment, :belongs_to, :user).first
  end.equals :pass

end
