require 'test_helper'

class CpxAdvertisementTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert CpxAdvertisement.new.valid?
  end
end
