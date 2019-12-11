class RoutesController < ApplicationController
  before_action :initialize_vessel
  before_action :initialize_route, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @route = @vessel.routes.new
  end

  def create
    redirect_to vessel_path(@vessel) if @vessel.routes.create(route_params)
  end

  def edit
  end

  def update
    redirect_to vessel_path(@vessel) if @route.update_attributes(route_params)
  end

  def destroy
    redirect_to vessel_path(@vessel) if @route.destroy
  end

  private

  def route_params
    params.require(:route).permit(:name, :distance, :origin, :destination)
  end

  def initialize_vessel
    @vessel = Vessel.find params[:vessel_id]
  end

  def initialize_route
    @route = @vessel.routes.find params[:id]
  end
end
