class SchedulesController < ApplicationController
  before_action :initialize_vessel_and_route
  before_action :initialize_schedule, only: [:edit, :update, :destroy]

  def new
    @schedule = @route.schedules.new
  end

  def create
    redirect_to vessel_route_path(vessel_id: @vessel.id, id: @route.id) if @route.schedules.create(schedule_params)
  end

  def edit
  end

  def update
    strong_params ||= params[:type].downcase.gsub('::', '_')
    redirect_to vessel_route_path(vessel_id: @vessel.id, id: @route.id) if @schedule.update_attributes(schedule_params(strong_params))
  end

  def destroy
    redirect_to vessel_route_path(vessel_id: @vessel.id, id: @route.id) if @schedule.destroy
  end

  private

  def schedule_params(strong_param = :schedule)
    params.require(strong_param).permit(:start_time, :end_time, :remarks, :date, :type, :days => []).merge(vessel: @vessel)
  end

  def initialize_vessel_and_route
    redirect_to root_path unless params[:vessel_id] || params[:route_id]

    @vessel = Vessel.find params[:vessel_id]
    @route  = @vessel.routes.find params[:route_id]
  end

  def initialize_schedule
    @schedule = @route.schedules.find params[:id]
  end
end
