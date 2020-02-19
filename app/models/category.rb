class Category < ApplicationRecord
  has_many :category_sales
  has_many :sales, through: :category_sales
  has_ancestry
end
