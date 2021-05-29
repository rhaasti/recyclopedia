class ProductsController < ApplicationController
  def index
    @products = Product.all
    # @products = Product.where(name: params[:name])
  end
end
