class Product < ApplicationRecord
  has_many :product_materials
  has_many :materials, through: :product_materials
  has_one_attached :photo
end
