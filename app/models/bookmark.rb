class Bookmark < ApplicationRecord
  belongs_to :product
  belongs_to :list
  validates :product_id, uniqueness: { scope: [:list_id] }
end
