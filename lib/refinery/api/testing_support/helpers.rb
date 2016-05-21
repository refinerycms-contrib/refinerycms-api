module Refinery
  module Api
    module TestingSupport
      module Helpers
        def json_response
          case body = JSON.parse(response.body)
          when Hash
            body.with_indifferent_access
          when Array
            body
          end
        end

        def assert_not_found!
          expect(json_response).to eq({ "error" => "The resource you were looking for could not be found." })
          expect(response.status).to eq 404
        end

        def assert_unauthorized!
          expect(json_response).to eq({ "error" => "You are not authorized to perform that action." })
          expect(response.status).to eq 401
        end

        def stub_authentication!
          allow(Refinery::Api.user_class).to receive(:find_by).with(hash_including(:refinery_api_key)) { current_api_user }
        end

        # This method can be overriden (with a let block) inside a context
        # For instance, if you wanted to have an admin user instead.
        def current_api_user
          @current_api_user ||= stub_model(Refinery::Api.user_class, email: "refinery@example.com")
        end

        def file_path(filename)
          File.open(Refinery::Api::Engine.root + "spec/fixtures" + filename)
        end

        def upload_file(filename, mime_type)
          fixture_file_upload(file_path(filename).path, mime_type)
        end
      end
    end
  end
end
