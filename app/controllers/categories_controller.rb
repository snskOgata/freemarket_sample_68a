class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @children = @category.children
    @parent = @children.parent
  end
end
