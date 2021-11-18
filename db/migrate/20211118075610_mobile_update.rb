class MobileUpdate < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :mobile, :bigint
  end
end
