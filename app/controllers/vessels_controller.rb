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
    # json = [{:title=>"All Day Event", :start=>"2019-08-01"}, {:title=>"Long Event", :start=>"2019-08-07", :end=>"2019-08-10"}, {:groupId=>999, :title=>"Repeating Event", :start=>"2019-08-09T16:00:00"}, {:groupId=>999, :title=>"Repeating Event", :start=>"2019-08-16T16:00:00"}, {:title=>"Conference", :start=>"2019-08-11", :end=>"2019-08-13"}, {:title=>"Meeting", :start=>"2019-08-12T10:30:00", :end=>"2019-08-12T12:30:00"}, {:title=>"Lunch", :start=>"2019-08-12T12:00:00"}, {:title=>"Meeting", :start=>"2019-08-12T14:30:00"}, {:title=>"Happy Hour", :start=>"2019-08-12T17:30:00"}, {:title=>"Dinner", :start=>"2019-08-12T20:00:00"}, {:title=>"Birthday Party", :start=>"2019-08-13T07:00:00"}, {:title=>"Click for Google", :url=>"http://google.com/", :start=>"2019-08-28"}]
    # render json: json
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
    params.require(:vessel).permit(:name)
  end

  def initialize_vessel
    @vessel = Vessel.find params[:id]
  end
end
