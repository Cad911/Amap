class AddPointRelaiIdToAbonnements < ActiveRecord::Migration
  def change
    add_column :abonnements, :point_relai_id, :integer

  end
end
