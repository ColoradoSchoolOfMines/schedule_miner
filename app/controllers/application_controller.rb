class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    # `where` rather than `find` so we don't crash on deleted users.
    @current_user ||= User.where(id: session[:user_id]).first if session[:user_id]
  end

  def correct_user?
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to static_path, :alert => "Access denied."
    end
  end

  def authenticate_user!
    if !current_user
      redirect_to static_path, :alert => 'You need to sign in for access to this page.'
    end
  end

  def user_has? permission
    if current_user
      if permission == :admin and current_user.admin_flag == 0
        return true
      end
    end

    false
  end

  def user_schedules 
    if current_user
      return Schedule.find_all_by_user_id(@current_user.uid)
    end
  end

  helper_method :current_user, :correct_user?, :authenticate_user!, :user_has?, :user_schedules
end
