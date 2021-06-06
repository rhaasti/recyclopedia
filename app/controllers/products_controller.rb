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
<<<<<<< HEAD
   # add-lists
 
=======
    #1. call search locations method to retrieve hash of long/lat of programs
    # @programs = 
    #2. iterate thru array long/lat of each program
    # @markers = @programs.geocoded.map do |program|
    # end
    #3. display on map
>>>>>>> master
    @bookmark = Bookmark.new

    @material_ids = @product.material_ids
    @zipcode = params[:zipcode]
    @programs = get_programs(@material_ids)
    #render error page if no zipcode
  
    @markers = []
    @program_ids = []

    @programs.each do |program|
      @program_ids << program["program_id"]

      @markers <<
        {
          lat: program["latitude"],
          lng: program["longitude"],
          info_window: render_to_string(partial: "info_window", locals: { program: get_program_info(program["program_id"]) } )
        }

    end
  end

  def search_by_material
    # Find products by material
      # Product.joins(product_materials: :material)
      # Product.joins(product_materials: [material: :material_material_families])
      # Product.joins(product_materials: [material: [material_material_families: :material_family]])
    # TO DO: validate params
    @products = Product.joins(product_materials:
      [material: [material_material_families: :material_family]]).where("material_families.description ILIKE ?",
      "%#{params[:material]}%")

    render "index"
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

  def get_program_info(program_id)
    url = "https://api.earth911.com/earth911.getProgramDetails?api_key=5b7412cae7282842&program_id=#{program_id}"
    result = JSON.parse(URI.open(url).read)["result"]
    @program_info = { description: result[program_id]["description"], hours: result[program_id]["hours"], phone: result[program_id]["phone"], notes: result[program_id]["notes_public"], curbside: result[program_id]["curbside"] }
  end
end
