class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @children = @category.children
    @parent = @category.parent
    # さらに親要素を持つならそれを代入
    if @parent
      @parent = @parent.parent.present? ? @parent.parent : @parent
    end
  end
end
