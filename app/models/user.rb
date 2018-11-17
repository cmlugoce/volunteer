class User < ActiveRecord::Base
  has_secure_password

  has_many :logs
    validates_uniqueness_of :username, :email
    validates_presence_of :username, :email, :password
  
end