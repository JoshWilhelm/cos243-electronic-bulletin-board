class Tile < ActiveRecord::Base
	attr_accessible :x_location, :y_location
	attr_protected :advertisement_id, :board_id, :cost

	belongs_to :advertisement
	has_one :board, through: :advertisement

	validates :x_location, presence:  true,
		:numericality => { :greater_than_or_equal_to => 0 }
	validates :y_location, presence:  true,
		:numericality => { :greater_than_or_equal_to => 0 }
	validates :cost, presence:  true,
		:numericality => { :greater_than_or_equal_to => 0 }

	validate :check_tile_bounds
	
	def age
	end
	private
		def check_tile_bounds
			unless x_location.nil?
				if x_location >= advertisement.width + advertisement.x_location
					errors.add(:x_location, "x_location past end of ad width")
				end
				
				if x_location >= board.width
					errors.add(:x_location, "x_location larger than board width")
				end
				
				if x_location <= advertisement.x_location
					errors.add(:x_location, "x_location smaller than ad x_location")
				end 
			end
			unless y_location.nil?
				if y_location >= advertisement.height + advertisement.y_location
					errors.add(:y_location, "y_location past end of ad height")
				end
				
				if y_location >= board.height
 					errors.add(:y_location, "y_location larger than board height")
 				end
 				
 				if y_location <= advertisement.y_location
 					errors.add(:y_location, "y_location smaller than ad y_location")
 				end 
			end	
		end
end