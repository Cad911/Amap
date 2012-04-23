class AddQuantiteToAbonnements < ActiveRecord::Migration
  def change
    add_column :abonnements, :quantite, :integer

  end
end
