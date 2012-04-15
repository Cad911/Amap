class AddEtatToAbonnements < ActiveRecord::Migration
  def change
    add_column :abonnements, :etat, :string

  end
end
