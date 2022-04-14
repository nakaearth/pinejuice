# frozen_string_literal: true

class HelloController <  ActionController::API
  def index
    render plain: 'ok'
  end
end
