module MyPagePatches
  module WelcomeControllerPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)

      base.class_eval do
        unloadable
        before_filter :landing_page_index, :only => :index
      end
    end

    module InstanceMethods
      def landing_page_index
        if User.current.logged? && ((Setting.plugin_redmine_my_page["homelink_override"] == "1") || params['force_redirect'] == '1')

          redirect_to my_page_url
        end
      end
    end
  end
end