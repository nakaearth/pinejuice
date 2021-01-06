# frozen_string_literal: true

class UserRegistrationForm
  include ActiveModel::Model

  attr_reader :name, :nickname, :email, :uid, :provider, :image_url, :secret, :token

  validates :name, presence: true
  validates :secret, presence: true
  validates :token, presence: true

  def initialize(request_parameters)
    @name = request_parameters[:name]

    raise UserRegistrationError.new(errors.full_messages, 'validation_failed') if invalid?
  end
end
