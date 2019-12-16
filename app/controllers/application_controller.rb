class ApplicationController < ActionController::Base
  before_action :authenticate_admin!
  before_action :set_page_title

  private

  def set_page_title
    @page_title = controller_name.upcase
  end
end
