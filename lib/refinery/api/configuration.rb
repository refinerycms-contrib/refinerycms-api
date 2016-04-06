module Refinery
  module Api
    include ActiveSupport::Configurable

    config_accessor :requires_authentication

    self.requires_authentication = true
  end
end