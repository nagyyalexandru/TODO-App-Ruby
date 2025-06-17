class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if verify_recaptcha(model: @user)
      if @user.save
        redirect_to root_path, notice: "Signup successful!"
      else
        flash.now[:alert] = "Signup failed!"
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "reCAPTCHA failed!"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
