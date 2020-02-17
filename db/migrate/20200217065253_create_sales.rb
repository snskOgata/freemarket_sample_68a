class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.string :name, null: false, limit: 40
      t.text :detail, null: false
      t.integer :condition_id, null: false
      t.integer :delivery_payer_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :prep_days_id, null: false
      t.integer :price, null: false
      t.integer :status_id, null: false, default: 0
      t.timestamps
    end
  end
end
