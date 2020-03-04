class CategoriesController < ApplicationController
  before_action :set_data
  def index
    # htmlなら早期リターン
    respond_to do |format|
      format.html
      
      # jsonの場合カテゴリ一覧を3階層にして渡す
      @data = []
      none = "選択してください"
      @data << {id: 0, name: none, sub: [{id: 0, name: none, sub: [{id: 0, name: none}]}]}
      @main_categories.each_with_index do |cat, i|
        @data << {id: cat.id, name: cat.name}
        @data[i + 1][:sub] = [{id: 0, name: none, sub: [{id: 0, name: none}]}]
        cat.children.each_with_index do |child, j|
          @data[i + 1][:sub] << {id: child.id, name: child.name}
          @data[i + 1][:sub][j + 1][:sub] = [{id: 0, name: none}]
          child.children.each do |gchild|
            @data[i + 1][:sub][j + 1][:sub] << {id: gchild.id, name: gchild.name}
          end
        end
      end
      format.json {render json: @data }
    end
  end
  
  def new
  end

  def show
    @sales = Sale.joins(:categories).where(categories: {id: params[:id]})
    @category = Category.find(params[:id])
    @children = @category.children
    @parent = @category.parent
    # さらに親要素を持つならそれを代入
    if @parent
      @parent = @parent.parent.present? ? @parent.parent : @parent
    end
  end

  private
    def set_data
      @main_categories = Category.where(id: 1..13)
      @shipping_item = nil
      if user_signed_in?
        @shipping_item = current_user.sales.where(status: 1)
      end
    end
end
