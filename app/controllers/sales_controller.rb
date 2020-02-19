class SalesController < ApplicationController
  
  def index
    @main_categories = Category.where(id: 1..13)

    # @children = @main_category.@children.where(id: 1..14)
  end

  def new
  end
  
end
