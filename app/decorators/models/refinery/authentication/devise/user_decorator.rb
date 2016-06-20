if defined?(Refinery::Api.user_class)
  Refinery::Api.user_class.class_eval do
    include Refinery::UserApiAuthentication
  end
end