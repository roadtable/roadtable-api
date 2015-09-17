class StaticPagesController < ApplicationController
  skip_before_action :set_session
  # layout false

  def index
    render template: "static_pages/index"
  end

end
