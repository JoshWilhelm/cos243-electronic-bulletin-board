class Advertisement < ActiveRecord::Base
  attr_accessible :height, :image, :width, :x_location, :y_location
	attr_protected :board_id, :user_id

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
	validate :check_advertisement_bounds
	
	
	private
		def check_advertisement_bounds
			if board.width<=x_location
				errors.add(:x_location, 'width out of bounds')
			end
			if board.height<=y_location
				errors.add(:y_location, 'height out of bounds')
 			end
		end
end
