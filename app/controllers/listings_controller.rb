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

  def purchase
  end

  def purchased
  end

  private
    def set_categories
      @main_categories = Category.where(id: 1..13)
    end
end
