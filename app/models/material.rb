class Material < ApplicationRecord
  has_many :product_materials
  has_many :material_material_families
  has_many :material_families, through: :material_material_families
  has_many :products, through: :product_materials
  has_many :programs
end
