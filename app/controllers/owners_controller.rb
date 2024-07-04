class OwnersController < ApplicationController
  def index
    @owners = Owner.all

    if params[:query].present?
      @owners = @owners.where('name LIKE ?', "%#{params[:query]}%")
    end

    @owners = @owners.page(params[:page]).per(10)
  end

  def show
    @owner = Owner.find(params[:id])
  end
end
