class ListsController < ApplicationController

def index
  @lists = List.where(params[:user] == current_user)
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
  @list.save
  redirect_to lists_path
end


private

def strong_params
  params.require(:list).permit(:name)
end

end
