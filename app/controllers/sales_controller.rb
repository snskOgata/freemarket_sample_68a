class SalesController < ApplicationController
  
  def index
    @main_categories = Category.where(id: 1..13)
    @sales = Sales.order(created_at: :desc).limit(3)
  end

  def new
  end
  
end
