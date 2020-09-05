class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.integer :wallet_id
      t.string :currency
      t.decimal :current_balance,  precision: 12, scale: 2, :default => 0.0
      t.string :numbers
      t.date :expiration_date
      t.string :ccv
      t.integer :user_id
      t.integer :status, :default => 1

      t.timestamps
    end
  end
end
