module Refinery
  module Api
    module TestingSupport
      module Setup
        def sign_in_as_admin!
          let!(:current_api_user) do
            user = stub_model(Refinery.user_class)
            allow(user).to receive_message_chain(:refinery_roles, :pluck).and_return(["admin"])
            allow(user).to receive(:has_refinery_role?).with("admin").and_return(true)
            user
          end
        end
      end
    end
  end
end
