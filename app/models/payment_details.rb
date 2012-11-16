class Payment_Details < ActiveRecord::Base
  attr_accessible :Detail, :amount, :payable_id, :payable_type, :user_id

	belongs_to :user
	belongs_to :payable, polymorphic: true
end
