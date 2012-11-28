class PaymentDetail < ActiveRecord::Base
  attr_accessible :amount, :user
	attr_protected :user_id, :payable_id, :payable_type

	belongs_to :user
	belongs_to :payable, polymorphic: true
	
	validates :amount, presence: true,
		:numericality => { :greater_than_or_equal_to => 0 }
end
