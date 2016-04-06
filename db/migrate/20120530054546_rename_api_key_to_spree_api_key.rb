class RenameApiKeyToRefineryApiKey < ActiveRecord::Migration
  def change
    unless defined?(User)
      rename_column :refinery_users, :api_key, :refinery_api_key
    end
  end
end
