class CreateCategorySales < ActiveRecord::Migration[5.2]
  def change
    create_table :category_sales do |t|
      t.references :category, foreign_key: true
      t.references :sale, foreign_key: true
      t.timestamps
    end
  end
end
