class User < ActiveRecord::Base
  attr_accessible :email, :fullname, :password, :password_confirmation

  has_secure_password

  validates :email, presence: true

  has_many :events, :dependent => :destroy
end
