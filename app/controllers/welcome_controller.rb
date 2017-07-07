class WelcomeController < ApplicationController
  def index
    render json: "App is Working"
  end
end
