class ApplicationController < ActionController::Base
  before_action :authenticate_member!, except: [:top, :about]
end