namespace :refinery_api do
  namespace :user do
    namespace :api_token do
      desc "Generate user API Token"
      task :generate => :environment do
        raise "USAGE: User email required e.g. 'EMAIL=refinery@example.org'" if ENV["EMAIL"].blank?
        user = Refinery::Api.user_class.find_by_email ENV["EMAIL"]
        user.generate_refinery_api_key! if user.present?
        puts "API TOKEN for #{ENV['EMAIL']}: #{user.refinery_api_key}"
        puts "Done!"
      end
    end
  end
end