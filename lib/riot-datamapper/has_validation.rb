module Riot
  module DataMapper
    class HasValidation < Riot::AssertionMacro
      register :has_validation

      def evaluate(model, validation, field, options={})

        validator = model.validators.context(:default).detect do |v|
          keyword = validation.to_s.match(/validates_(\w+)_of/)[1]
          v.class.inspect.downcase =~ /#{keyword}/ && v.field_name.to_sym == field.to_sym
        end

        fail_msg    = "expected #{model} to have validation :#{validation} on :#{field}"
        pass_msg    = "#{model} has validation :#{validation} on :#{field}"
        options_msg = " with options #{options.inspect}"

        return fail(fail_msg) if validator.nil?

        unless options.empty?
          if options.all? { |key, value| validator.options[key] == value }
            pass_msg << options_msg
          else
            return fail(fail_msg + options_msg)
          end
        end

        pass(pass_msg)
      end
    end
  end
end
