class RemoveUidFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :uid
    remove_column :users, :provider
  end
end
