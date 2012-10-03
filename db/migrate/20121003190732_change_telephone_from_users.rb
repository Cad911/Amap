class ChangeTelephoneFromUsers < ActiveRecord::Migration
  def up
      change_column :users, :telephone, :string
  end

  def down
  end
end
