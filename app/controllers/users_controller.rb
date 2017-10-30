class UsersController < ApplicationController
  def index
    @users = User.all
  end

  #dive16課題で追記
  def show
    @user = User.find(params[:id])
  end
end
