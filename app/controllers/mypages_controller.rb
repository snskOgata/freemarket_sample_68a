class MypagesController < ApplicationController
  def show
    @main_categories = Category.where(id: 1..13)
  end

  def new
    @main_categories = Category.where(id: 1..13)
  end

  def logout
    @main_categories = Category.where(id: 1..13)
  end

end
