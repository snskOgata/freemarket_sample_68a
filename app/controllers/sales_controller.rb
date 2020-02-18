class SalesController < ApplicationController
  def index
    @sales = Sale.where(id: 1..3)
  end
end
