class List < ApplicationRecord
  belongs_to :user
  has_many :bookmarks
  has_many :products, through: :bookmarks
  validates :name, uniqueness: { scope: :user }
end
