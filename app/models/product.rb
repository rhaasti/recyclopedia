class Product < ApplicationRecord
  has_many :product_materials
  has_many :materials, through: :product_materials
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_upc_or_description,
    against: [ :UPC, :description ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
