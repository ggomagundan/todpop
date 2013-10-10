# -*- encoding : utf-8 -*-
require 'test_helper'

class AppInfoTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert AppInfo.new.valid?
  end
end
