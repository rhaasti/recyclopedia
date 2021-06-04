class ProductsController < ApplicationController

  def index
    if params[:query].present?
      @products = Product.search_by_upc_or_description(params[:query])
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
