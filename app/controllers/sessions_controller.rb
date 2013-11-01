class SessionsController < ApplicationController
  # before_filter :find_model

  def create
    # raise env['omniauth.auth'].to_yaml
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to static_path, notice: 'Signed in!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to static_path, notice: 'Signed out!'
  end
  

  # private
  # def find_model
  #   @model = Sessions.find(params[:id]) if params[:id]
  # end
end