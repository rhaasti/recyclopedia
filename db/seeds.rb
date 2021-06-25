Bookmark.destroy_all
List.destroy_all
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
  new_product = Product.create(description:"Hawaiian Punch Fruit Juicy Red", size:"10 fl oz Bottle", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["60","619", "40"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
  end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/91nisFfx94L._SL1500_.jpg")
  new_product = Product.create(description:"Quaker Oats Quick 1-Minute Oatmeal", size:"18 oz Canisters", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["411","619"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
  end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81FG-Ru44aL._SL1500_.jpg")
  new_product = Product.create(description:"Fage, Total 2%\ Yogurt", size:"35.3 oz", UPC:Faker::Barcode.upc_a)
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
  new_product = Product.create(description:"Grade A Milk", size:"128 fl oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["62","619"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81N4kw-uzgL._SL1500_.jpg")
  new_product = Product.create(description:"Tim Hortons Original Blend", size:"48 oz Canister", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["435","619"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71SVj6jT1LL._AC_SL1500_.jpg")
  new_product = Product.create(description:"Sealed Lead Acid Rechargeable Car Battery", size:"12V 35Ah", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["4", "368"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/8100M6%2BG2qL._SL1500_.jpg")
  new_product = Product.create(description:"Happy Belly California Walnuts", size:"40 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["583"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71qYSTnXCvL._AC_SL1500_.jpg")
  new_product = Product.create(description:"Purina One Natural Wet Cat Food", size:"3 oz cans", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["435"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71Rfcmf2p6L._SL1446_.jpg")
  new_product = Product.create(description:"Frito Lay Potato Chips", size:"7.75 oz Bag", UPC:Faker::Barcode.upc_a)
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
  new_product = Product.create(description:"Duracell - CopperTop AA Alkaline Batteries (28 Battery Count)", size:"28 batteries", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["104", "42"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81LFgedBa9L._SL1500_.jpg")
  new_product = Product.create(description:"Ocean Spray Juice Boxes", size:"4.2 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["236"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://i5.walmartimages.com/asr/03bc78d2-4e19-481a-81f4-2d9a988f76c6.66b75a18f8167489c27b8f2267c64812.jpeg")
  new_product = Product.create(description:"Coca-Cola 6-pack bottles", size:"12 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["77", "42"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/715H6OmNfRL._AC_SL1500_.jpg")
  new_product = Product.create(description:"Organic Respiratory Health Liquid Drops", size:"1 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["76", "42"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71RfLsC2a1L._SL1414_.jpg")
  new_product = Product.create(description:"Saratoga Sparkling Water", size:"28 oz", UPC:Faker::Barcode.upc_a)
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

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81aECON81yL._AC_SL1500_.jpg")
  new_product = Product.create(description:"HP Stream 14-Inch Laptop", size:"14 inch screen", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["491"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71zZNBi%2BCsL._AC_SL1100_.jpg")
  new_product = Product.create(description:"Samsung 43\" LCD TV", size:"43 inch screen", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["229"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71HCTwXtOxL._AC_SL1200_.jpg")
  new_product = Product.create(description:"Energizer AA Lithium Batteries (24 Battery Count)", size:"24 Batteries", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["689", "42"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81lj2n%2BMvzL._AC_SL1500_.jpg")
  new_product = Product.create(description:"Loctite Insulating Foam Sealant", size:"12 oz Can", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["187"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/51-yGrRQniL._SL1000_.jpg")
  new_product = Product.create(description:"Gasoila Stainless Steel Polish", size:"15 oz Aerosol", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["121"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/61AFVkiFwTL._AC_SL1500_.jpg")
  new_product = Product.create(description:"Prestone Synthetic Brake Fluid", size:"12 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["108"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/61Z9uo9ikhS._AC_SL1500_.jpg")
  new_product = Product.create(description:"Miracle-Gro Water Soluble All Purpose Plant Food", size:"10 lb", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["183"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71fLAeT5GZL._AC_SL1500_.jpg")
  new_product = Product.create(description:"Southern AG Weed Killer", size:"32 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["181"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71eiLXH7ENL._SL1500_.jpg")
  new_product = Product.create(description:"Clorox Bleach 77 oz bottle", size:"77 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["184"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/91AilfH3ZwL._AC_SL1500_.jpg")
  new_product = Product.create(description:"Rust-Oleum Latex Paint", size:"1 qt", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["418"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/61UKyREvrGL._AC_SL1000_.jpg")
  new_product = Product.create(description:"Dell Inspiron Laptop Battery", size:"49wh", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["615"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71Yqn81Vw6L._AC_SL1200_.jpg")
  new_product = Product.create(description:"Energizer Alkaline D Cell Batteries (12 Battery Count)", size:"12 Batteries", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["689", "42"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81vNbt3EtLL._AC_SL1500_.jpg")
  new_product = Product.create(description:"Tenergy AA Rechargeable Nickel-Cadmium Batteries (24 Battery Count)", size:"24 Batteries", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["126", "42"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81UoLyqIloL._AC_SL1500_.jpg")
  new_product = Product.create(description:"Energizer Silver Oxide Batteries (3 Battery Count)", size:"3 Batteries", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["547", "42"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71wWnt6pZ9L._AC_SL1500_.jpg")
  new_product = Product.create(description:"BIC Classic Lighter, Fashion Assorted Colors", size:"10 Pack", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["517"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71NtMXSKaYL._AC_SL1500_.jpg")
  new_product = Product.create(description:"Method All Purpose Natural Surface Cleaning Spray", size:"28 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["184"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://www.kroger.com/product/images/large/left/0008768401036")
  new_product = Product.create(description:"Capri Sun Juice Drink Variety Pack", size:"6 fl oz Pouches", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["631", "411"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81eq%2Bp5qXcL._SL1500_.jpg")
  new_product = Product.create(description:"Campbell's Chicken Noodle Soup", size:"10.5 oz Can", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["73"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/91NEtJv-JmL._SL1500_.jpg")
  new_product = Product.create(description:"Cento San Marzano Organic Peeled Tomatoes", size:"28 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["73"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://target.scene7.com/is/image/Target/GUEST_2f4999ad-21da-482d-b038-fa4a919b8677?fmt=webp&wid=1400&qlt=80")
  new_product = Product.create(description:"Rao's Marinara Sauce", size:"15.5 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["77"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images.costcobusinessdelivery.com/ImageDelivery/imageService?profileId=12028466&itemId=165011&recipeName=470&viewId=1")
  new_product = Product.create(description:"Camel Blue Cigarettes, 1 Carton", size:"10 packs", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["693"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81jiOAQVjdL._AC_SL1500_.jpg")
  new_product = Product.create(description:"Windex Aerosol Foaming Glass Cleaner", size:"19.7 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["121"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81crmp95EaL._SL1500_.jpg")
  new_product = Product.create(description:"TRESemmé Shampoo Argan Oil Smooth and Silky", size:"28 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["455"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/71qp5iAYAlS._SL1500_.jpg")
  new_product = Product.create(description:"Hellmann's Real Mayonnaise", size:"48 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["448"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81KuZ9WGZAL._SL1500_.jpg")
  new_product = Product.create(description:"Planters Salted Peanuts", size:"9.5 oz Canister,", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["73", "458"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://images-na.ssl-images-amazon.com/images/I/81ADjHBts3L._SL1500_.jpg")
  new_product = Product.create(description:"Polaner Premium White Chopped Garlic", size:"10 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["432", "434"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://www.colonialspirits.com/wp-content/uploads/2016/01/Lone-Star-Beer-6-bottles.jpg")
  new_product = Product.create(description:"Lone Star Beer 6-pack", size:"12 oz", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["76", "42"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://www.totalwine.com/dynamic/x1000,sq/media/sys_master/twmmedia/ha5/h5b/14404638212126.png")
  new_product = Product.create(description:"Tanqueray London Dry Gin", size:"1 L", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["102", "389"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end

1.times do
  file = URI.open("https://cdn.shopify.com/s/files/1/0013/2477/7569/products/bulleit_c2f26668-48a0-42d3-8ec7-f4b78e2f950a_1200x1200.jpg?v=1597790558")
  new_product = Product.create(description:"Bulleit Bourbon", size:"750 ml", UPC:Faker::Barcode.upc_a)
  new_product.photo.attach(io: file, filename: 'product.png', content_type: 'image/png')
  pair_material = ["76", "389"]
    pair_material.each do |external_id|
      material = Material.find_by(external_id: external_id)
      ProductMaterial.create(product_id:new_product.id,material_id:material.id)
    end
end


puts "...created #{Product.count} products"
puts "...created #{ProductMaterial.count} product / material pairings"











