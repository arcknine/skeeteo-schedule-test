class HomeController < ApplicationController
  before_action :authenticate_admin!

  def index
    @vessels = Vessel.all
  end
end
