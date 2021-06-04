class ProductsController < ApplicationController
  require "json"
  require "open-uri"

  def index
    if params[:query].present?
      @products = Product.search_by_upc_or_description(params[:query])
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])

    
    #1. call search locations method to retrieve hash of long/lat of programs
    @programs = get_programs
    #2. iterate thru array long/lat of each program
    @markers = @programs.geocoded.map do |program|
    @markers =
      {
        lat: program.latitude,
        lng: program.longitude
      }
    end
    #3. display on map
  end

  private
  def get_programs
    url = "https://api.earth911.com/earth911.getPostalData?api_key=5b7412cae7282842&country=us&postal_code=#{current_user.zip_code}"
    result_serialized = URI.open(url).read
    result = JSON.parse(result_serialized)
    lat = result["result"]["latitude"]
    lng = result["result"]["longitude"]

    program_url = "https://api.earth911.com/earth911.searchPrograms?api_key=5b7412cae7282842&latitude=#{lat}&longitude=#{lng}"
    result_serialized = URI.open(program_url).read
    result = JSON.parse(result_serialized)
  end
end
