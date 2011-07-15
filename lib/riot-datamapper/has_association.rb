module Riot
  module DataMapper
    class HasAssociation < Riot::AssertionMacro
      register :has_association

      MAPPINGS = {
        :has_n      => 'OneToMany',
        :has_1      => 'OneToOne',
        :belongs_to => 'ManyToOne',
      }

      def evaluate(model, type, assoc, options = {})
        relationship = model.relationships[assoc]
        fail_msg     = "expected #{model} to have an association with :#{assoc}"
        pass_msg     = "#{model} has an association with :#{assoc}"
        type_msg     = " of type '#{type}'"
        options_msg  = " with options #{options.inspect}"

        return fail(fail_msg) if relationship.nil?

        if options[:through]
          through_type = 'ManyToMany'
          if relationship.through.name == options[:through]
            pass_msg << options_msg
          else
            return fail(fail_msg + options_msg)
          end
        end

        if relationship.class.to_s.include?(through_type || MAPPINGS[type])
          pass_msg << type_msg
        else
          return fail(fail_msg + type_msg)
        end

        pass(pass_msg)
      end

    end
  end
end
