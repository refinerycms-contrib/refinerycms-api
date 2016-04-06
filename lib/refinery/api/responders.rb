require 'refinery/api/responders/rabl_template'

module Refinery
  module Api
    module Responders
      class AppResponder < ActionController::Responder
        include RablTemplate
      end
    end
  end
end
