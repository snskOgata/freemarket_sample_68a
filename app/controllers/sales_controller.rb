class SalesController < ApplicationController

  before_action :set_sale, only: [:edit, :update, :show, :destroy]
  before_action :set_data, only: [:index, :show]  

  def index
    @sales = Sale.order(created_at: :desc).limit(3)
  end

  def new
    redirect_to new_user_session_path unless user_signed_in?
    @sale = Sale.new
    @sale.photos.build()
  end
  
  def show
    @sale = Sale.find(params[:id])
    @prev_sale = Sale.where("id < ?", @sale.id).order('id DESC').limit(1)[0]
    @next_sale = Sale.where("id > ?", @sale.id).limit(1)[0]
    respond_to do |format|
      format.html
      format.json {render json: {
        photos: @sale.photos,
        categories: @sale.categories
      }}
    end
  end


  def create
    redirect_to new_user_session_path unless user_signed_in?
    @sale = Sale.new(sale_params)
    if !params[:sale][:category_ids].include?(0) && @sale.save
      redirect_to root_path
    else
      @sale.photos.build
      render :new
    end
  end

  def edit
  end

  def update
    redirect_to new_user_session_path unless user_signed_in?
    # ユーザが出品者で、カテゴリに不適切なidが含まれておらず、バリデーションを通過した時のみ保存
    if @sale.seller.id == current_user.id && !params[:sale][:category_ids].include?(0) && @sale.update(sale_params)
      redirect_to sale_path(@sale.id)
    else
      @sale.photos.build
      render :edit
    end
  end


  def destroy
    if @sale.seller_id == current_user.id
      @sale.destroy
      redirect_to mypage_path
      flash[:alert] = '商品を削除しました'
    else
      redirect_to mypage_path
      flash[:alert] = '商品削除に失敗しました'
    end
  end

  def shipped
    @sale = Sale.find(params[:sale_id]) 
    if @sale.seller_id == current_user.id && @sale.status == "shipping"
      @sale.update(status:"soldout")
      redirect_to root_path, notice: '出品完了を受理しました'
    else
      flash.now[:alert] = 'データの更新に失敗しました'
      render "show"
    end
  end

  private 
    def sale_params
      params.require(:sale).permit(:name, :detail, :condition_id, :delivery_payer_id, :prefecture_id, :prep_days_id, :price, category_ids: [], photos_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
    end

    def set_sale
      @sale = Sale.find(params[:id]) 
    end

    def set_data
      @main_categories = Category.where(id: 1..13)
      @shipping_item = nil
      if user_signed_in?
        @shipping_item = current_user.sales.where(status: 1)
      end
    end
end


