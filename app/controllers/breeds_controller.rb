class BreedsController < ApplicationController
  def index
    @breeds = Breed.all

    if params[:query].present?
      @breeds = @breeds.where('breeds.name LIKE ?', "%#{params[:query]}%")
    end

    if params[:owner_id].present?
      @breeds = @breeds.joins(:owners).where('owners.id = ?', params[:owner_id]).distinct
    end

    @breeds = @breeds.page(params[:page]).per(10)
  end

  def show
    @breed = Breed.includes(:breed_detail, :images, :sub_breeds).find(params[:id])
    unless @breed.breed_detail
      redirect_to breeds_path, alert: "Breed data is incomplete"
    end
  end
end
