class SubBreedsController < ApplicationController
  def show
    @sub_breed = SubBreed.find(params[:id])
  end
end
