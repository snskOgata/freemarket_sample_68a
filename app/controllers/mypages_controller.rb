class MypagesController < ApplicationController
  before_action :set_data
  def show
  end

  def logout
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
