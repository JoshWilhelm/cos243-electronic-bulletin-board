class PaymentDetail < ActiveRecord::Base
  attr_accessible :amount
	attr_protected :user_id, :payable_id, :payable_type

	belongs_to :user
	belongs_to :payable, polymorphic: true
end
