module Refinery
  module UserApiAuthentication
    def generate_refinery_api_key!
      self.refinery_api_key = generate_refinery_api_key
      save!
    end

    def clear_refinery_api_key!
      self.refinery_api_key = nil
      save!
    end

    private

    def generate_refinery_api_key
      SecureRandom.hex(24)
    end
  end
end