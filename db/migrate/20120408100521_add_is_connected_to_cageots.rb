class AddIsConnectedToCageots < ActiveRecord::Migration
  def change
    add_column :cageots, :is_connected, :integer

    add_column :cageots, :session_id, :string

  end
end
