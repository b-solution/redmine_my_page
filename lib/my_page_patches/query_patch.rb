module MyPagePatches
  module QueryPatch

    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)

      base.class_eval do
        unloadable

      end
    end

    module InstanceMethods
      def as_params
        if new_record?
          params = {}
          filters.each do |field, options|
            params[:f] ||= []
            params[:f] << field
            params[:op] ||= {}
            params[:op][field] = options[:operator]
            params[:v] ||= {}
            params[:v][field] = options[:values]
          end
          params[:c] = column_names
          params[:sort] = sort_criteria.to_param
          params[:set_filter] = 1
          params
        else
          {:query_id => id}
        end
      end

    end
  end
end