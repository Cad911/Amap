class AddSessionIdToAbonnements < ActiveRecord::Migration
  def change
    add_column :abonnements, :session_id, :string

  end
end
