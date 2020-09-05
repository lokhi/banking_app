class CreateWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
      t.decimal :current_balance,  precision: 12, scale: 2, :default => 0.0
      t.string :currency
      t.integer :company_id
      t.boolean :master, :default => false

      t.timestamps
    end
  end
end
