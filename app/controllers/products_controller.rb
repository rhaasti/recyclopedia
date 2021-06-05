class ProductsController < ApplicationController
  require "json"
  require "open-uri"
  skip_before_action :authenticate_user!, except: [:lists]

  def index
    if params[:query].present?
      @products = Product.search_by_upc_or_description(params[:query])
      @temporal_zipcode = TemporalZipcode.create(zipcode: params[:zipcode])
    else
      @products = Product.includes(:materials)
    end
  end

  def show
    @product = Product.find(params[:id])
    
    @zipcode = params[:zipcode] 
    @programs = get_programs(@zipcode)
    #render error page if no zipcode
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
  def get_programs(zipcode)
    url = "https://api.earth911.com/earth911.getPostalData?api_key=5b7412cae7282842&country=us&postal_code=#{zipcode}"
    result_serialized = URI.open(url).read
    result = JSON.parse(result_serialized)
    lat = result["result"]["latitude"]
    lng = result["result"]["longitude"]

    program_url = "https://api.earth911.com/earth911.searchPrograms?api_key=5b7412cae7282842&latitude=#{lat}&longitude=#{lng}"
    result_serialized = URI.open(program_url).read
    result = JSON.parse(result_serialized)
    programs = result["result"]
    return programs
    # @markers = programs.geocoded.map do |program|
    #   @markers =
    #     {
    #       lat: program.latitude,
    #       lng: program.longitude
    #     }
    #   end
  end
end
