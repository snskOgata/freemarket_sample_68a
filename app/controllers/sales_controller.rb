class SalesController < ApplicationController

  before_action :set_sale, only: [:edit, :show, :destroy]

  def index
    @main_categories = Category.where(id: 1..13)
    @sales = Sale.order(created_at: :desc).limit(3)
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
    if !params[:sale][:category_ids].include?(0) && params[:sale_photos][:image].present? && @sale.save
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
  end

  def update
  end


  def destroy
    if @sale.seller_id == current_user.id
      @sale.destroy
      redirect_to root_path
      flash[:alert] = '商品を削除しました'
    else
      redirect_to root_path
      flash[:alert] = '商品削除に失敗しました'
    end
  end

  private 
    def sale_params
      params.require(:sale).permit(:name, :detail, :condition_id, :delivery_payer_id, :prefecture_id, :prep_days_id, :price, category_ids: []).merge(seller_id: current_user.id)
    end

  def set_sale
    @sale = Sale.find(params[:id]) 
  end
end


