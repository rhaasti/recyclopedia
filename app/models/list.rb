class List < ApplicationRecord
  belongs_to :user
  has_many :products, through: :bookmarks

end
