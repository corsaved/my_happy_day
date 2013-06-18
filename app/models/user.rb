class User < ActiveRecord::Base
  attr_accessible :email, :fullname, :password_digest
end
