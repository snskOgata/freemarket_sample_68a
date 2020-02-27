class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :buyer, foreign_key: {to_table: :users}, null:false
      t.references :sale , foreign_key: true,               null:false

      t.timestamps
    end
  end
end
