class HomeController < ApplicationController
  before_action :check_role, except: :index
  def index; end

  def profile; end
end

