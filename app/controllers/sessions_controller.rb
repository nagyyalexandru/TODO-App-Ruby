class SessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(user_params.to_h)

    if @user_session.save
      # Store the user's id in the session
      user = @user_session.record
      session[:user_id] = user.id

      # flash[:notice] = "Welcome back, #{user.email}!"
      redirect_to root_path
    else
      flash[:alert] = "Invalid email or password."
      render :new
    end
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:notice] = "Logged out successfully."
    end
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user_session).permit(:email, :password)
  end
end
