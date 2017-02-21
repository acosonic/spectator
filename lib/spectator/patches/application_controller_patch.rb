module Spectator
	module Patches
		module ApplicationControllerPatch

			def self.included(base)

        base.send(:include, ApplicationControllerInstanceMethods)

        base.class_eval do
        	prepend_before_action :_enable_session_from_redmine_plugin
        	alias_method :logout_user_without_spectator, :logout_user
        end
      end
		end

		module ApplicationControllerInstanceMethods

			def logout_user
		    session[:spectator_id] = nil
		    logout_user_without_spectator
		  end

		protected
		  def _enable_session_from_redmine_plugin
		    spec_id = session[:spectator_id] || nil
		    Redmine::Plugin.send(:define_method, "spectator_id", proc { spec_id })
		  end
		end

	end
end

unless ApplicationController.included_modules.include?(Spectator::Patches::ApplicationControllerPatch)
  ApplicationController.send(:include, Spectator::Patches::ApplicationControllerPatch)
end