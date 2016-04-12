class AddApiKeyToRefineryUsers < ActiveRecord::Migration
  def change
    if defined?(User)
      add_column :refinery_users, :api_key, :string, :limit => 40
    end
  end
end
