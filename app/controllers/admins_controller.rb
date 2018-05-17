class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  layout 'admins'

  def index

  end
end