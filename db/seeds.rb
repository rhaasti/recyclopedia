# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# ProductMaterial.destroy_all
# Product.destroy_all
# Material.destroy_all

# puts "...clean database"

# require 'faker'
# require "json"
# require "open-uri"

# 50.times do

#   upc = "012000001345"

#   puts upc

#   url = "https://api.earth911.com/earth911.getProductDetails?api_key=5b7412cae7282842&upc=#{upc}"
#   product_serialized = URI.open(url).read
#   product = JSON.parse(product_serialized)

#   if product["num_results"] == 0
#     puts "UPC not found"
#   else
#     description = product["result"][upc]["description"]
#     size = product["result"][upc]["size"]
#     materials = product["result"][upc]["materials"]

#     if Product.exists?(:UPC => upc)
#     else
#       @new_product = Product.create(description:description,size:size,UPC:upc)
#     end

#     materials.each do |material|
#       if Material.exists?(:external_id => "#{material["material_id"]}")
#          @existing_material = Material.find_by(external_id: "#{material["material_id"]}")
#          ProductMaterial.create(product_id:@new_product.id,material_id:@existing_material.id)
#       else
#         @new_material = Material.create(description:"#{material["description"]}",external_id:"#{material["material_id"]}")
#         ProductMaterial.create(product_id:@new_product.id,material_id:@new_material.id)
#       end
#     end
#   end
# end


# puts "...created #{Product.count} products, #{Material.count} materials, and #{ProductMaterial.count} product/material pairings"

Bookmark.destroy_all
MaterialMaterialFamily.destroy_all
ProductMaterial.destroy_all
MaterialFamily.destroy_all
Product.destroy_all
Material.destroy_all

puts "...clean database"

require "json"
require "open-uri"

puts "...creating materials"

url = "https://api.earth911.com/earth911.getMaterials?api_key=5b7412cae7282842"
result_serialized = URI.open(url).read
result = JSON.parse(result_serialized)

materials = result["result"]

materials.each do |material|
  material = Material.create(:description => "#{material["description"]}",:external_id => "#{material["material_id"]}", :long_description => "#{material["long_description"]}")
end

puts "...created #{Material.count} materials"

puts "...creating material families"

url = "https://api.earth911.com/earth911.getFamilies?api_key=5b7412cae7282842"
result_serialized = URI.open(url).read
result = JSON.parse(result_serialized)

families = result["result"]

families.each do |family|
  MaterialFamily.create(external_id:family["family_id"],description:family["description"])
end

delete_family1 = MaterialFamily.find_by(external_id: "108")
delete_family1.destroy

delete_family2 = MaterialFamily.find_by(external_id: "106")
delete_family2.destroy

delete_family3 = MaterialFamily.find_by(external_id: "81")
delete_family3.destroy

puts "...created #{MaterialFamily.count} material families"

puts "...creating material / family pairings"

url = "https://api.earth911.com/earth911.getFamilies?api_key=5b7412cae7282842"
result_serialized = URI.open(url).read
result = JSON.parse(result_serialized)

families = result["result"]

families.each do |family|
  material_family = MaterialFamily.find_by(external_id: family["family_id"]) #spacing
  array = family["material_ids"]
  unless array.nil?
    array.each do |material|
      found_material = Material.find_by(external_id: material)
      if found_material && material_family
          MaterialMaterialFamily.create(material_family_id: material_family.id,material_id: found_material.id)
      end
    end
  end
end

puts "...created #{MaterialMaterialFamily.count} material / family pairings"

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81wt8S28PNS._SL1500_.jpg")
  new_product = Product.create(description:"Hawaiian Punch Fruit Juicy Red", size:"10 Fluid Ounce Bottle", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["60","619", "40"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
  end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/91nisFfx94L._SL1500_.jpg")
  new_product = Product.create(description:"Quaker Oats Quick 1-Minute Oatmeal", size:"18oz Canisters", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["411","619"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
  end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81FG-Ru44aL._SL1500_.jpg")
  new_product = Product.create(description:"Fage, Total 2%\ Yogurt", size:"35.3 Ounce", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["466"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/813UygtWF-L._SL1500_.jpg")
  new_product = Product.create(description:"Coca-Cola 12-pack cans", size:"12 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["70","42"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81gJfkzwjnL._SL1500_.jpg")
  new_product = Product.create(description:"Driscoll's Berry Big Strawberries", size:"18 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["625", "447"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81BPIb8FD8L._SL1500_.jpg")
  new_product = Product.create(description:"Oatly Original Oat Milk", size:"64 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["411","619"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71jvnaMaPZL._SL1500_.jpg")
  new_product = Product.create(description:"Grade A Milk", size:"128 Fl Oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["62","619"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81N4kw-uzgL._SL1500_.jpg")
  new_product = Product.create(description:"Tim Hortons Original Blend", size:"48 Ounce Canister", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["435","619"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71SVj6jT1LL._AC_SL1500_.jpg")
  new_product = Product.create(description:"Sealed Lead Acid Rechargeable Battery", size:"12V 35Ah", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["4", "368"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/8100M6%2BG2qL._SL1500_.jpg")
  new_product = Product.create(description:"Happy Belly California Walnuts", size:"40 Ounce", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["583"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71qYSTnXCvL._AC_SL1500_.jpg")
  new_product = Product.create(description:"Purina One Natural Wet Cat Food", size:"3 oz. cans", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["435"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71Rfcmf2p6L._SL1446_.jpg")
  new_product = Product.create(description:"Frito Lay Potato Chips", size:"7.75oz Bag", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["583"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/517cJC1ys7L._AC_SL1024_.jpg")
  new_product = Product.create(description:"Lodge Pre-Seasoned Cast Iron Skillet", size:"10.25 inch diameter", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["388"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71vR9M3xZNL._AC_SL1500_.jpg")
  new_product = Product.create(description:"Valvoline Multi-Vehicle Antifreeze/Coolant", size:"1 gallon", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["3"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71QSY%2BGchOL._SL1500_.jpg")
  new_product = Product.create(description:"Heavy Duty Aluminum Foil", size:"300 sq feet", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["235"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/41lMGrajEOL._AC_.jpg")
  new_product = Product.create(description:"Duracell - CopperTop AA Alkaline Batteries", size:"28 pack", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["104", "42"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81LFgedBa9L._SL1500_.jpg")
  new_product = Product.create(description:"Ocean Spray Juice Boxes", size:"4.2oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["236"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://i5.walmartimages.com/asr/03bc78d2-4e19-481a-81f4-2d9a988f76c6.66b75a18f8167489c27b8f2267c64812.jpeg")
  new_product = Product.create(description:"Coca-Cola 6-pack bottles", size:"12oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["77", "42"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/715H6OmNfRL._AC_SL1500_.jpg")
  new_product = Product.create(description:"Organic Respiratory Health Liquid Drops", size:"1oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["76", "42"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71RfLsC2a1L._SL1414_.jpg")
  new_product = Product.create(description:"Saratoga Sparkling Water", size:"28oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["255"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/91MTJzmrBpL._AC_SL1500_.jpg")
  new_product = Product.create(description:"Brawny Flex Paper Towels", size:"8 rolls", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["427"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end


puts "...created #{Product.count} products"
puts "...created #{ProductMaterial.count} product / material pairings"











