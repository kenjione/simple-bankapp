class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.integer :user_id, index: true, null: false
      t.decimal :balance, precision: 8, scale: 2, null: false, default: 0.0

      t.timestamps
    end
  end
end
