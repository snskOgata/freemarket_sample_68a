class Controller < ApplicationController
  def index
    @sale = Sale.new
    @sales = @sale.photos
  end
end
