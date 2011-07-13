module Riot
  module DataMapper
    class HasProperty < Riot::AssertionMacro
      register :has_property

      def evaluate(model, field, *macro_info)
        type, options = macro_info
        property      = model.properties[field]
        fail_msg      = "expected #{model} to have property :#{field}"
        pass_msg      = "#{model} has property :#{field}"
        type_msg      = " with type '#{type}'"
        options_msg   = " with options #{options.inspect}"

        return fail(fail_msg) if property.nil?

        if type
          if property.class.to_s.include? type
            pass_msg << type_msg
          else
            return fail(fail_msg + type_msg)
          end
        end

        if options
          mismatch = options.reject do |key,value|
            property.method(key).call == value
          end
          if mismatch.empty?
            pass_msg<<(options_msg)
          else
            return fail(fail_msg + options_msg)
          end
        end

        pass(pass_msg)
      end

    end
  end
end
