# frozen_string_literal: true

class HelloController < ApplicationController
  def index
    render plain: 'ok'
  end
end
