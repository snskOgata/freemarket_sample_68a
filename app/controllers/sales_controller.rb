class SalesController < ApplicationController
  
  def index
    @main_categories = Category.where(id: 1..13)

    # @children = @main_category.@children.where(id: 1..14)
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    if @sale.save
      redirect_to root_path, notice: '商品を出品しました'
    else
      render :new
    end
  end

  private 
    def sale_params
      params.require(:sale).permit(:name, :detail, :condition_id, :delivery_payer_id, :prefecture_id, :prep_days_id, :price, category_ids: []).merge(seller_id: current_user.id)
    end
end
