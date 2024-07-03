class BreedsController < ApplicationController
  def index
    @breeds = Breed.page(params[:page]).per(10)
  end

  def show
    @breed = Breed.find(params[:id])
  end
end
