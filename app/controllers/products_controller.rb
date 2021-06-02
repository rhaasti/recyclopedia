class ProductsController < ApplicationController

  def index
    @products = Product.all
    # @products = Product.where(name: params[:name])
  end

  def show
    @product = Product.find(params[:id])
  end
end
