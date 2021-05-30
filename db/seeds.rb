# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ProductMaterial.destroy_all
Product.destroy_all
Material.destroy_all

puts "clean database"

require "json"
require "open-uri"

1.times do

  upc = "012000001345"

  url = "https://api.earth911.com/earth911.getProductDetails?api_key=5b7412cae7282842&upc=#{upc}"
  product_serialized = URI.open(url).read
  product = JSON.parse(product_serialized)

  description = product["result"][upc]["description"]
  size = product["result"][upc]["size"]
  materials = product["result"][upc]["materials"]

  if Product.exists?(:UPC => upc)
  else
    @new_product = Product.create(description:description,size:size,UPC:upc)
  end

  materials.each do |material|
    if Material.exists?(:external_id => "#{material["material_id"]}")
       @existing_material = Material.find_by(external_id: "#{material["material_id"]}")
       ProductMaterial.create(product_id:@new_product.id,material_id:@existing_material.id)
    else
      @new_material = Material.create(description:"#{material["description"]}",external_id:"#{material["material_id"]}")
      ProductMaterial.create(product_id:@new_product.id,material_id:@new_material.id)
    end
  end
end

1.times do

  upc = "039800099099"

  url = "https://api.earth911.com/earth911.getProductDetails?api_key=5b7412cae7282842&upc=#{upc}"
  product_serialized = URI.open(url).read
  product = JSON.parse(product_serialized)

  description = product["result"][upc]["description"]
  size = product["result"][upc]["size"]
  materials = product["result"][upc]["materials"]

  if Product.exists?(:UPC => upc)
  else
    @new_product = Product.create(description:description,size:size,UPC:upc)
  end

  materials.each do |material|
    if Material.exists?(:external_id => "#{material["material_id"]}")
       @existing_material = Material.find_by(external_id: "#{material["material_id"]}")
       ProductMaterial.create(product_id:@new_product.id,material_id:@existing_material.id)
    else
      @new_material = Material.create(description:"#{material["description"]}",external_id:"#{material["material_id"]}")
      ProductMaterial.create(product_id:@new_product.id,material_id:@new_material.id)
    end
  end
end

1.times do

  upc = "049000028904"

  url = "https://api.earth911.com/earth911.getProductDetails?api_key=5b7412cae7282842&upc=#{upc}"
  product_serialized = URI.open(url).read
  product = JSON.parse(product_serialized)

  description = product["result"][upc]["description"]
  size = product["result"][upc]["size"]
  materials = product["result"][upc]["materials"]

  if Product.exists?(:UPC => upc)
  else
    @new_product = Product.create(description:description,size:size,UPC:upc)
  end

  materials.each do |material|
    if Material.exists?(:external_id => "#{material["material_id"]}")
       @existing_material = Material.find_by(external_id: "#{material["material_id"]}")
       ProductMaterial.create(product_id:@new_product.id,material_id:@existing_material.id)
    else
      @new_material = Material.create(description:"#{material["description"]}",external_id:"#{material["material_id"]}")
      ProductMaterial.create(product_id:@new_product.id,material_id:@new_material.id)
    end
  end
end
