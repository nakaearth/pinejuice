class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 60 }
  validates :uid, presence: true
  validates :email, length: { maximum: 60 }
  validates :provider, presence: true, length: { maximum: 30 }    
end