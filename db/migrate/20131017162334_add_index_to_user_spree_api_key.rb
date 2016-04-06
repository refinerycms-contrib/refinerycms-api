class AddIndexToUserRefineryApiKey < ActiveRecord::Migration
  def change
    unless defined?(User)
      add_index :refinery_users, :refinery_api_key
    end
  end
end
