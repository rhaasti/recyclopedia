class ProductsController < ApplicationController
  require "json"
  require "open-uri"
  skip_before_action :authenticate_user!, except: [:lists]

  def index
    @bookmark = Bookmark.new
    if params[:query].present?
      @products = Product.search_by_upc_or_description(params[:query]).order("description ASC")
      @temporal_zipcode = TemporalZipcode.create(zipcode: params[:zipcode])
    else
      @products = Product.includes(:materials).order("description ASC")
    end
    url = "https://api.earth911.com/earth911.getPostalData?api_key=5b7412cae7282842&country=us&postal_code=#{params[:zipcode]}"
    data = JSON.parse(URI.open(url).read)
    if params[:zipcode].present? && data["code"] == 0
      redirect_to root_path, alert: data["error"]
    end
  end

  def show_from_zipcode
    @product = Product.find(params[:product_id])

    redirect_to "#{product_path(@product)}?zipcode=#{params[:zipcode]}"
  end

  def show
    @product = Product.find(params[:id])

    @bookmark = Bookmark.new

    @material_external_ids = []
    get_material_external_ids
  end

  def search_by_material
    @products = Product.joins(product_materials:
      [material: [material_material_families: :material_family]]).where("material_families.description ILIKE ?",
      "%#{params[:material]}%").order("description ASC")
    @products = @products.uniq # or .distinct, test speed
    @bookmark = Bookmark.new
  end
end

private

def get_material_external_ids
  @product.materials.each do |material|
    @material_external_ids << material.external_id
  end
end
