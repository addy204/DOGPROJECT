class BreedsController < ApplicationController
  def index
    @breeds = Breed.all

    if params[:query].present?
      @breeds = @breeds.where('name LIKE ?', "%#{params[:query]}%")
    end

    if params[:owner_id].present?
      @breeds = @breeds.joins(:owners).where(owners: { id: params[:owner_id] }).distinct
    end

    @breeds = @breeds.page(params[:page]).per(10)
  end

  def show
    @breed = Breed.find(params[:id])
  end
end
