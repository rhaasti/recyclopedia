class ProductMaterial < ApplicationRecord
  belongs_to :product
  belongs_to :material
  validates :product_id, uniqueness: { scope: [:material_id] }

end
