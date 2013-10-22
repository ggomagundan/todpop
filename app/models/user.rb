# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base

  has_secure_password

  has_many :advertise_logs
  has_many :points
  has_many :attendances
  has_many :advertise_cpd_logs
  has_many :advertise_cpdm_logs
  has_many :advertise_cpx_logs

end
