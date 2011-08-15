require File.expand_path('../teststrap', __FILE__)

context "has_validation macro" do
  setup do
    Object.send(:remove_const, :FooBar) if Object.const_defined?(:FooBar)

    class FooBar
      include DataMapper::Resource

      property :id,  Serial
      property :foo, String
      property :bar, Integer
      property :buzz, Integer

      validates_presence_of     :foo
      validates_numericality_of :bar
      validates_length_of       :buzz, :maximum => 20
    end
    DataMapper.finalize ; FooBar
  end

  asserts "that it passes when the model has the validation" do
    Riot::DataMapper::HasValidation.new.evaluate(topic, :validates_presence_of, :foo).first
  end.equals :pass

  asserts "that it fails when the model does not have the validation" do
    Riot::DataMapper::HasValidation.new.evaluate(topic, :validates_presence_of, :bar).first
  end.equals :fail

  asserts "that it passes when the model has the validation and options" do
    Riot::DataMapper::HasValidation.new.evaluate(topic, :validates_length_of, :buzz, :maximum => 20).first
  end.equals :pass

  asserts "that it fails when the model does not have the validation and options" do
    Riot::DataMapper::HasValidation.new.evaluate(topic, :validates_length_of, :buzz, :maximum => 30).first
  end.equals :fail

  asserts "that it has message when the model has the validation and options" do
    Riot::DataMapper::HasValidation.new.evaluate(topic, :validates_length_of, :buzz, :maximum => 20).last
  end.equals "FooBar has validation :validates_length_of on :buzz with options {:maximum=>20}"

end
