require File.expand_path('../teststrap', __FILE__)

context "has_property macro" do
  setup do
    Object.send(:remove_const, :FooBar) if Object.const_defined?(:FooBar)

    class FooBar
      include DataMapper::Resource

      property :foo, String
      property :bar, Serial
      property :monkey, Boolean, :default => false
    end
    DataMapper.finalize ; FooBar
  end

  asserts "that it passes when the model has the property" do
    Riot::DataMapper::HasProperty.new.evaluate(topic, :bar).first
  end.equals :pass

  asserts "that it has message when it passes when the model has the property" do
    Riot::DataMapper::HasProperty.new.evaluate(topic, :bar).last
  end.equals "FooBar has property :bar"

  denies "that it passes when the model does not have the property" do
    Riot::DataMapper::HasProperty.new.evaluate(topic, :wahhh).first
  end.equals :pass

  asserts "that it passes when the model has the property and type" do
    Riot::DataMapper::HasProperty.new.evaluate(topic, :bar, 'Serial').first
  end.equals :pass

  asserts "that it has message when it passes when the model has the property and type" do
    Riot::DataMapper::HasProperty.new.evaluate(topic, :bar, 'Serial').last
  end.equals "FooBar has property :bar with type 'Serial'"

  denies "that it passes when the model does not have the property and type" do
    Riot::DataMapper::HasProperty.new.evaluate(topic, :bar, 'String').first
  end.equals :pass

  asserts "that it pass when the model has property, type, and options" do
    Riot::DataMapper::HasProperty.new.evaluate(topic, :monkey, 'Boolean', :default => false).first
  end.equals :pass

  asserts "that it pass when the model has property, type, and options" do
    Riot::DataMapper::HasProperty.new.evaluate(topic, :monkey, 'Boolean', :default => false).last
  end.equals "FooBar has property :monkey with type 'Boolean' with options {:default=>false}"

  denies "that it will pass when the model has property, type but not options" do
    Riot::DataMapper::HasProperty.new.evaluate(topic, :monkey, 'Boolean', :required => true).first
  end.equals :pass

end
