# -*- encoding : utf-8 -*-
class AdvertiseLog < ActiveRecord::Base

  belongs_to :advertisement, :dependent => :destroy
  belongs_to :user, :dependent => :destroy

  
end
