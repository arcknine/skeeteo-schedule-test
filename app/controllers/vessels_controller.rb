class VesselsController < ApplicationController
  before_action :initialize_vessel, only: [:show, :edit, :update, :destroy, :calendar, :feed]

  include ApplicationHelper

  def show
    @routes = @vessel.routes
  end

  def calendar
  end

  def feed
    schedules = @vessel.schedules.in_date_range(params[:start], params[:end])
    render json: Schedule.parse_json_for_fullcalendar(schedules)
  end

  def new
    @vessel = Vessel.new
  end

  def create
    @vessel = Vessel.new vessel_params
    redirect_to root_path if @vessel.save
  end

  def edit
  end

  def update
    redirect_to root_path if @vessel.update_attributes(vessel_params)
  end

  def destroy
    redirect_to root_path if @vessel.destroy
  end

  private

  def vessel_params
    params.require(:vessel).permit(:name, :decommissioned)
  end

  def initialize_vessel
    @vessel = Vessel.find params[:id]
  end
end
