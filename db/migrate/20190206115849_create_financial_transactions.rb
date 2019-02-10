class CreateFinancialTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_transactions do |t|
      t.string  :refferer
      t.string  :type, null: false
      t.integer :amount, precision: 8, scale: 2, null: false
      t.integer :account_id, index:true, null: false

      t.text    :description

      t.timestamps
    end
  end
end
