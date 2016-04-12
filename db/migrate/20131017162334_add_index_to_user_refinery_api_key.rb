class AddIndexToUserRefineryApiKey < ActiveRecord::Migration
  def change
    if defined?(User)
      add_index :refinery_users, :refinery_api_key
    end
  end
end
