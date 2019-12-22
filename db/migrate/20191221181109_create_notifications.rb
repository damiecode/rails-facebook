class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.integer :other_user_id
      t.string :type
      t.integer :type_id

      t.timestamps
    end
  end
end
