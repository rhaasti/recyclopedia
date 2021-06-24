class Product < ApplicationRecord
  has_many :product_materials
  has_many :materials, through: :product_materials
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_upc_or_description,
    against: [ :UPC, :description ],
    using: {
      tsearch: { prefix: true }
    }

  def bookmarked?(user)
    return false if user.nil?

    user_lists = List.where(user: user)
    user_lists_ids = user_lists.pluck(:id)
    bookmarks = Bookmark.where(list_id: user_lists_ids, product: self)
    bookmarks.any?
  end
end
