class User < ActiveRecord::Base

  has_secure_password

  has_many :advertise_logs
  has_many :points
  has_many :attendances

end
