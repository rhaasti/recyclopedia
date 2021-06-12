class BookmarksController < ApplicationController

  def new
    @bookmark = Bookmark.new
    @product = Product.find(params[:product_id])
    @list = List.find(params[:list_id])
  end

  def create
    @bookmark = Bookmark.new(strong_bookmark_params)
    @product = Product.find(params[:product_id])
    @bookmark.product = @product
    @bookmark.save!
  end

private

def strong_bookmark_params
  params.require(:bookmark).permit(:product_id, :list_id)
end
end
