class ApplicationController < ActionController::API
  before_action :current_user

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def current_user
    if login?
      @current_user ||= User.find(Base64.decode64(session[:encrypted_user_id]))
    else
      nil
    end
  rescue ActiveRecord::RecordNotFound => ar
    logger.info "ユーザ情報がありません: #{ar.message}"
    session[:user_id] = nil
    nil
  end

  def login?
    session[:encrypted_user_id].present?
  end

  # TODO: ここ修正する
  def render_404
    render file: "#{Rails.root}/public/404.html", status: 404
  end
end
