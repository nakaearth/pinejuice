# frozen_string_literal: true

module UserRegistration
  class TwitterUserUsecase
    class << self
      def execute(email:, name:, uid:, nickname:, image_url:, credentials: {})
        ActiveRecord::Base.transaction do
          User.find_or_create_by!(email: email, provider: 'twitter') do |user|
            user.name = name
            user.email = email
            user.provider = 'twitter'
            user.uid = uid
            user.nickname = nickname
            user.image_url = image_url
            user.access_token = credentials[:token]
            user.secret_token = credentials[:secret]
          end
        rescue StandardError
          raise UserRegistrationError.new('Twitterのユーザ登録に失敗しました。', 'user_registration_error')
        end
      end
    end
  end
end
