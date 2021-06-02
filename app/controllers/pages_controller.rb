require 'json'
require 'open-uri'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def search
    url = "https://api.earth911.com/earth911.getProductDetails?api_key=5b7412cae7282842&upc=#{params[:upc]}"
    results_serialized = URI.open(url).read
    results = JSON.parse(results_serialized)
  end
end
