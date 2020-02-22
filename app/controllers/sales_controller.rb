class SalesController < ApplicationController

  def index
    @main_categories = Category.where(id: 1..13)
  end

  def new
    redirect_to new_user_session_path unless user_signed_in?
    @sale = Sale.new
    @sale.photos.build()
  end
  
  def show
    @sale = Sale.find(params[:id])
    @main_categories = Category.where(id: 1..13)
  end


  def create
    redirect_to new_user_session_path unless user_signed_in?
    @sale = Sale.new(sale_params)
    if params[:sale_photos][:image].present? && @sale.save
      params[:sale_photos][:image].each do |image|
        @sale.photos.create(image: image, sale_id: @sale.id)
      end
      redirect_to root_path
    else
      @sale.photos.build
      render :new
    end
  end

  def edit
    @sale = Sale.find(params[:id])
  end

  def update
  end

  def destroy
    sale = Sale.find(params[:id])
    sale.destroy
    redirect_to root_path
  end

  private 
    def sale_params
      params.require(:sale).permit(:name, :detail, :condition_id, :delivery_payer_id, :prefecture_id, :prep_days_id, :price, category_ids: [], photos_attributes: [:image]).merge(seller_id: current_user.id)
    end
end
