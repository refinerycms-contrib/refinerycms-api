module Refinery
  module Api
    module ControllerHelpers
      module Auth
        extend ActiveSupport::Concern
        include Refinery::Api::TokenGenerator

        included do
          before_action :set_guest_token
          helper_method :try_refinery_current_user

          rescue_from CanCan::AccessDenied do |exception|
            redirect_unauthorized_access
          end
        end

        # Needs to be overriden so that we use Refinery's Ability rather than anyone else's.
        def current_ability
          @current_ability ||= Refinery::Ability.new(try_refinery_current_user)
        end

        def redirect_back_or_default(default)
          redirect_to(session["refinery_user_return_to"] || request.env["HTTP_REFERER"] || default)
          session["refinery_user_return_to"] = nil
        end

        def set_guest_token
          if cookies.signed[:guest_token].blank?
            cookies.permanent.signed[:guest_token] = generate_guest_token
          end
        end

        def store_location
          # disallow return to login, logout, signup pages
          authentication_routes = [:refinery_signup_path, :refinery_login_path, :refinery_logout_path]
          disallowed_urls = []
          authentication_routes.each do |route|
            if respond_to?(route)
              disallowed_urls << send(route)
            end
          end

          disallowed_urls.map!{ |url| url[/\/\w+$/] }
          unless disallowed_urls.include?(request.fullpath)
            session['refinery_user_return_to'] = request.fullpath.gsub('//', '/')
          end
        end

        # proxy method to *possible* refinery_current_user method
        # Authentication extensions (such as refinery_auth_devise) are meant to provide refinery_current_user
        def try_refinery_current_user
          # This one will be defined by apps looking to hook into Refinery
          # As per authentication_helpers.rb
          if respond_to?(:refinery_current_user)
            refinery_current_user
          # This one will be defined by Devise
          elsif respond_to?(:current_refinery_user)
            current_refinery_user
          else
            nil
          end
        end

        # Redirect as appropriate when an access request fails.  The default action is to redirect to the login screen.
        # Override this method in your controllers if you want to have special behavior in case the user is not authorized
        # to access the requested action.  For example, a popup window might simply close itself.
        def redirect_unauthorized_access
          if try_refinery_current_user
            flash[:error] = Refinery.t(:authorization_failure)
            redirect_to refinery.forbidden_path
          else
            store_location
            if respond_to?(:refinery_login_path)
              redirect_to refinery_login_path
            else
              redirect_to refinery.respond_to?(:root_path) ? refinery.root_path : main_app.root_path
            end
          end
        end

      end
    end
  end
end