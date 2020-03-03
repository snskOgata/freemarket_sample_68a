class ListingsController < ApplicationController
  before_action :set_categories
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
    def set_categories
      @main_categories = Category.where(id: 1..13)
    end
end
