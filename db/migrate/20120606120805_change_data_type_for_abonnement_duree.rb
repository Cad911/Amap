class ChangeDataTypeForAbonnementDuree < ActiveRecord::Migration
  def up
      change_column :abonnements, :duree, :integer
  end

  def down
  end
end
