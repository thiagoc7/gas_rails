class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    omniauth
  end

  private
  def omniauth
    auth = request.env["omniauth.auth"]

    if user_signed_in?
      current_user.provider = auth.provider
      current_user.uid = auth.uid
      current_user.save!
      sign_in_and_redirect current_user
      return true
    end

    @user = User.from_omniauth(auth)

    if @user.persisted?
      sign_in_and_redirect @user
    else
      session["devise.google_oauth2_data"] = request.env["omniauth.auth"]
      redirect_to new_session_path @user
    end
  end
end