class ProductsController < ApplicationController

  def index
    @products = Product.all
    # @products = Product.where(name: params[:name])
  end

  def show
    @product = Product.find(params[:id])
    #1. call search locations method to retrieve hash of long/lat of programs
    # @programs = 
    #2. iterate thru array long/lat of each program
    # @markers = @programs.geocoded.map do |program|
    #   {
    #     lat: program.latitude,
    #     lng: program.longitude
    #   }
    # end
    #3. display on map
  end
end
