class Advertisement < ActiveRecord::Base
  attr_accessible :height, :image, :width, :x_location, :y_location, :charge, :image_contents=
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
	
	def charge
	end
	
	def image_contents=(object)
		self.image = object.read()
	end
  	
  	
	private
		def check_advertisement_bounds
			unless x_location.nil?
				if board.width <= x_location
					errors.add(:x_location, "width out of bounds")
				end
				if width > board.width
					errors.add(:x_location, "height larger than board height")
				end
				if board.width < (x_location + width)
					errors.add(:x_location, "x_location & width combined larger than board width")
				end
			end
			unless y_location.nil?
				if board.height <= y_location
					errors.add(:y_location, "height out of bounds")
 				end
 				if height > board.height
					errors.add(:y_location, "height larger than board height")
				end
				if board.height < (y_location + height)
					errors.add(:y_location, "y_location & height combined larger than board height")
				end
 			end
		end
end
