class MyCoupon < ActiveRecord::Base

COUPON_TYPE = {
	:FREE => 0,
	:NOT_FREE => 1
}

def kind
	return MyCoupon::COUPON_TYPE.key(self.coupon_type)
end

end
