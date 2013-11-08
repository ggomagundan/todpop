# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base

  has_secure_password

  has_many :advertise_cpd_logs
  has_many :advertise_cpdmlogs
  has_many :advertise_cpx_logs
  has_many :reward_logs
  has_many :point_logs
  has_many :advertise_cpd_logs
  has_many :advertise_cpdm_logs
  has_many :advertise_cpx_logs


  after_create do |u|
    #u.update_attributes(:last_connection => DateTime.now, :attendance_time => 1)
                                    # assumption : login or connection = taking at least one exam
    u.update_attributes(:daily_test_count => 0)
   
  end


end
