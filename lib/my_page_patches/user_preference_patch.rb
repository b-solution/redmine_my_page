module MyPagePatches
  module UserPreferencePatch

    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)

      base.class_eval do
        unloadable
        # safe_attributes 'landing_page', 'my_activity', 'my_cust_query'
      end
    end

    module InstanceMethods
      def landing_page; self[:landing_page] end
      def landing_page=(value); self[:landing_page]=value end

      def my_page_settings(block=nil)
        s = self[:my_page_settings] ||= {}
        if block
          s[block] ||= {}
        else
          s
        end
      end

      def update_block_settings(block, settings)
        block = block.to_s
        block_settings = my_page_settings(block).merge(settings.symbolize_keys)
        my_page_settings[block] = block_settings
      end

      def my_activity
        if self[:my_activity].nil?
          self[:my_activity] = Hash.new
          self[:my_activity][:query_ids]= []
          self[:my_activity][:limit]= 10
          save
        end
        self[:my_activity]
      end

      def my_activity=(value); self[:my_activity]=value end

      def my_cust_query
        if self[:my_cust_query].nil?
          self[:my_cust_query] = Hash.new
          self[:my_cust_query][:query_ids]= []
          save
        end
        self[:my_cust_query]
      end

      def my_cust_query=(value); self[:my_cust_query]=value end
    end
  end
end