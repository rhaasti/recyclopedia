class BookmarksController < ApplicationController

  def new
    @bookmark = Bookmark.new
    @product = Product.find(params[:product_id])
    @list = List.where("user_id = #{current_user.id}")
  end

  def create
    @bookmark = Bookmark.new(strong_bookmark_params)
    @product = Product.find(params[:product_id])
    @bookmark.product = @product
    if @bookmark.save
      respond_to do |format|
        format.js { flash.now[:notice] = "Product added to list!"}
      # redirect_to product_path(@product, zipcode:params[:bookmark][:zipcode]), notice: "your product has been added to the list"
      end
    else
      respond_to do |format|
        format.js { flash.now[:alert] = "Product has already been added to this list!"}
      # redirect_to product_path(@product, zipcode:params[:bookmark][:zipcode]), alert: "your product has already been added to this list!"
      end
    end


  end

private

def strong_bookmark_params
  params.require(:bookmark).permit(:product_id, :list_id)
end
end
