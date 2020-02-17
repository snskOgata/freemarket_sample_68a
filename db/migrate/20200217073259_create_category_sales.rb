class CreateCategorySales < ActiveRecord::Migration[5.2]
  def change
    create_table :category_sales do |t|

      t.timestamps
    end
  end
end
