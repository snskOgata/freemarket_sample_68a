class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.string :name,           null: false
      t.text :detail,           null: false
      t.integer :condition,     null: false
      t.integer :delivery_payer,null: false
      t.integer :prefecture,    null: false
      t.integer :prep_days,     null: false
      t.integer :price,         null: false
      t.integer :status,        null: false
      t.references :seller,     foreign_key: { to_table: :users}
      t.timestamps
    end
  end
end
