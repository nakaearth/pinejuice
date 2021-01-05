# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :login?, only: %i[new create destroy oauth_failure]

  def new
    redirect_to '/auth/' + (Rails.env.production? ? params[:provider] : 'developer')
  end

  def create
    auth_params = request.env['omniauth.auth']
    form = UserRistrationForm.new(auth_params)
    user =
      User.find_by(provider: form.provider, email: form.name) ||
      UserRegistration::TwitterUserUsecase.call(
        email: form.email,
        name: form.name,
        uid: form.uid,
        nickname: form.nickname,
        image_url: form.image_url,
        credentials: { secret: form.secret, token: form.token }
      )
    @current_user_json =
      {
         encrypted_user_id: Base64.encode64(user.id.to_s),
         name: user.name,
         nickname: user
      }
  end

  def destroy
    reset_session
    redirect_to controller: 'top', action: 'index', notice: 'login successfully.'
  end

  def oauth_failure
    flash[:notice] = "キャンセルしました。"
    redirect_to "/"
  end
end
