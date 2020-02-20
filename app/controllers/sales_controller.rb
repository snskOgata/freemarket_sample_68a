class SalesController < ApplicationController

  def index
    @main_categories = Category.where(id: 1..13)

    # @children = @main_category.@children.where(id: 1..14)
  end

  def new
    @sale = Sale.new
    @sale.photos.build()
  end
  
  def show
  end


  def create
    @sale = Sale.new(sale_params)
    if @sale.save
        params[:sale_photos][:image].each do |image|
          @sale.photos.create(image: image, sale_id: @sale.id)
        end
      redirect_to root_path
    else
      @sale.photos.build
      render :new
    end
  end

  private 
    def sale_params
      params.require(:sale).permit(:name, :detail, :condition_id, :delivery_payer_id, :prefecture_id, :prep_days_id, :price, category_ids: [], photos_attributes: [:image]).merge(seller_id: current_user.id)
    end
end
