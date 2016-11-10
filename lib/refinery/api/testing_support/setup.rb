module Refinery
  module Api
    module TestingSupport
      module Setup
        def sign_in_as_user!
          let!(:current_api_user) do
            user = stub_model(Refinery::Api.user_class)
            allow(user).to receive_message_chain(:roles, :pluck).and_return(["refinery"])
            allow(user).to receive(:has_role?).with("refinery").and_return(true)
            user
          end
        end

        def sign_in_as_admin!
          let!(:current_api_superuser) do
            user = stub_model(Refinery::Api.user_class)
            allow(user).to receive_message_chain(:roles, :pluck).and_return(["superuser"])
            allow(user).to receive(:has_role?).with("superuser").and_return(true)
            user
          end
        end
      end
    end
  end
end
