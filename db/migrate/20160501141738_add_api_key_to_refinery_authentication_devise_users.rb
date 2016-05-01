class AddApiKeyToRefineryAuthenticationDeviseUsers < ActiveRecord::Migration
  def change
    unless defined?(User)
      add_column :refinery_authentication_devise_users, :refinery_api_key, :string, limit: 48
      add_index :refinery_authentication_devise_users, :refinery_api_key
    end
  end
end
