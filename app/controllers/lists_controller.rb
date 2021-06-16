class ListsController < ApplicationController

def index
  @lists = List.where("user_id = #{current_user.id}")
end

def show
  @list = List.find(params[:id])
end

def new
  @list = List.new
end

def create
  @list = List.create(strong_params)
  @list.user = current_user
  if @list.save
      respond_to do |format|
        format.js { flash[:notice] = "your new list has been created"}
      end
      redirect_to lists_path
    else
      respond_to do |format|
        format.js { flash.now[:alert] = "you already have a list with this name!"}
      end
    end
end

private

def strong_params
  params.require(:list).permit(:name)
end

end
