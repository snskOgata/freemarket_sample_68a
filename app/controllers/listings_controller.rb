class ListingsController < ApplicationController
  before_action :set_data
  before_action :need_login
  def listing
    @status = 0
    @sales = current_user.sales.where(status: @status)
    render 'listing'
  end

  def in_progress
    @status = 1
    @sales = current_user.sales.where(status: @status)
    render 'listing'
  end

  def completed
    @status = 2
    @sales = current_user.sales.where(status: @status)
    render 'listing'
  end

  def purchasing
    @status = 1
    orders = current_user.orders
    @sales =[]
    orders.each do |order|
      sale = Sale.where(id: order.sale_id, status: @status)[0]
      @sales << sale if sale.present?
    end
  end

  def purchased
    @status = 2
    orders = current_user.orders
    @sales =[]
    orders.each do |order|
      sale = Sale.where(id: order.sale_id, status: @status)[0]
      @sales << sale if sale.present?
    end
    render 'purchasing'
  end

  private
    def set_data
      @main_categories = Category.where(id: 1..13)
      @shipping_item = nil
      if user_signed_in?
        @shipping_item = current_user.sales.where(status: 1)
      end
    end

    def need_login
      redirect_to new_user_session_path unless user_signed_in?
    end
end
