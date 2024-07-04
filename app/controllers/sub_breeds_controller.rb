class SubBreedsController < ApplicationController
  def show
    @sub_breed = SubBreed.find(params[:id])
    # Fetch additional data for the sub-breed if needed
  end
end
