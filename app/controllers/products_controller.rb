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
    @material_ids = @product.material_ids
    @zipcode = params[:zipcode]
    @programs = get_programs(@material_ids)
    #render error page if no zipcode
    @markers = []
    @programs.each do |program|
      @markers <<
        {
          lat: program["latitude"],
          lng: program["longitude"]
        }
    end
  end

  private
  def zipcode_to_coordinates(zipcode)
    url = "https://api.earth911.com/earth911.getPostalData?api_key=5b7412cae7282842&country=us&postal_code=#{zipcode}"
    result_serialized = URI.open(url).read
    result = JSON.parse(result_serialized)
    @lat = result["result"]["latitude"]
    @lng = result["result"]["longitude"]
  end
  
  def get_programs(material_ids)
    zipcode_to_coordinates(@zipcode)
    program_url = "https://api.earth911.com/earth911.searchPrograms?api_key=5b7412cae7282842&latitude=#{@lat}&longitude=#{@lng}&material_ids=#{material_ids}"
    result_serialized = URI.open(program_url).read
    result = JSON.parse(result_serialized)
    programs = result["result"]
  end
end
