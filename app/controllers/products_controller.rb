class ProductsController < ApplicationController

  def index
    if params[:upc].present?
      @products = Product.search_by_upc(params[:upc])
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
