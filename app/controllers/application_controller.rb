class ApplicationController < ActionController::API
  before_action :set_session

  def set_session
    if params[:api_key]
      unless Session.where(:api_key => params[:api_key]) == []
        @session = Session.where(:api_key => params[:api_key]).first
      else
        render json: "Invalid api key."
      end
    else
      render json: "An api key is needed for this action."
    end
  end

end
