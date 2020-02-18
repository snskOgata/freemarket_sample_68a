class SalesController < ApplicationController
  
  def index
    @sales = Sale.last(id: 3)
  end

  def new
  end
  
end
