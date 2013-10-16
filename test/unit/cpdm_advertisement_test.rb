require 'test_helper'

class CpdmAdvertisementTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert CpdmAdvertisement.new.valid?
  end
end
