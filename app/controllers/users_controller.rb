class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    raw_recaptcha_response = params["g-recaptcha-response"]
    Rails.logger.debug "Raw reCAPTCHA response: #{raw_recaptcha_response.inspect}"

    if verify_recaptcha(model: @user)
      if @user.save
        redirect_to root_path, notice: "Signup successful!"
      else
        flash.now[:alert] = "Signup failed!"
        render :new, status: :unprocessable_entity
      end
    else
      recaptcha_reply = request.env["recaptcha.reply"]
      error_codes = recaptcha_reply ? (recaptcha_reply["error-codes"] || []) : [ "unknown" ]

      Rails.logger.debug "reCAPTCHA failed with errors: #{error_codes.join(', ')}"

      flash.now[:alert] = "reCAPTCHA verification failed: #{error_codes.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
