class Advertisement < ActiveRecord::Base
  attr_accessible :height, :image, :width, :x_location, :y_location
	attr_protected :user_id, :board_id

	has_many :tiles
	belongs_to :user
	belongs_to :board
	has_many :payment_details, as: :payables

	validates :x_location, presence:  true,
		:numericality => { :greater_than_or_equal_to => 0 }
	validates :y_location, presence:  true,
			:numericality => { :greater_than_or_equal_to => 0 }
	validates :width, presence:  true,
			:numericality => { :greater_than_or_equal_to => 0 }
	validates :height, presence:  true,
			:numericality => { :greater_than_or_equal_to => 0 }
	validates :image, presence:  true

end
