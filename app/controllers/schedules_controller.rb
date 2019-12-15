class SchedulesController < ApplicationController
  before_action :initialize_vessel_and_route
  before_action :initialize_schedule, only: [:edit, :update, :destroy]

  def new
    @schedule = @initializer.schedules.new
  end

  def create
    redirect_to @path if @initializer.schedules.create(schedule_params)
  end

  def edit
  end

  def update
    strong_params ||= params[:type].downcase.gsub('::', '_')
    redirect_to @path if @schedule.update_attributes(schedule_params(strong_params))
  end

  def destroy
    redirect_to @path if @schedule.destroy
  end

  private

  def schedule_params(strong_param = :schedule)
    params.require(strong_param).permit(:start_time, :end_time, :remarks, :date, :type, :days => []).merge(vessel: @vessel)
  end

  def initialize_vessel_and_route
    redirect_to root_path unless params[:vessel_id]

    @vessel = Vessel.find params[:vessel_id]
    @route  = @vessel.routes.find params[:route_id] rescue nil

    @initializer = @route || @vessel
    @path = @route.present? ? vessel_route_path(vessel_id: @vessel.id, id: @route.id) : calendar_vessel_path(@vessel)
  end

  def initialize_schedule
    @schedule = @initializer.schedules.find params[:id]
  end
end
