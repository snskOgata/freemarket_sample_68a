class ErrorsController < ApplicationController
  def error_page
    @main_categories = Category.where(id: 1..13)
  end
end