class ServicesController < ApplicationController
  before_action :set_service, only: [ :show, :edit, :update, :destroy ]

  def index
    if params[:category]
      @services = Service.where(category: params[:category])
    else
      @services = Service.all
    end
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.user = current_user
    if @service.save
      redirect_to service_path(@service)
    else
      render :new
    end
  end

  def show
    @review = Review.new
  end

  def edit;end

  def update
    @service.update(service_params)
    redirect_to service_path(@service)
  end

  def destroy
    @service.destroy
    redirect_to services_path
  end

  private
  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:category, :description, :price, :city)
  end

end
