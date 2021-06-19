class Bookmark < ApplicationRecord
  belongs_to :product
  belongs_to :list
  validates :product, uniqueness: { scope: :list }
  # validates :zipcode, uniqueness: { scope: :product }
end
