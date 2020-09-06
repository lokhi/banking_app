class CreateTransfers < ActiveRecord::Migration[6.0]
  def change
    create_table :transfers do |t|
      t.decimal :amount
      t.string :origin_currency
      t.string :target_currency
      t.decimal :conversion_fee,  precision: 12, scale: 2, :default => 0.0
      t.references :origin_transfer, polymorphic: true, index: true
      t.references :target_transfer, polymorphic: true, index: true
      t.integer :user_id
      t.timestamps
    end
  end
end
