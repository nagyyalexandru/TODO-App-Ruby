class SessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(user_params.to_h)  # convert to hash
    if @user_session.save
      redirect_to root_path, notice: "Logged in successfully"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user_session).permit(:email, :password)
  end
end
