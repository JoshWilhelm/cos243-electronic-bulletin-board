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
	
	before_create :create_tiles
  	before_create :charge
	
	def image_contents=(object)
		self.image = object.read()
	end
	
	def charge
  		# total_cost = 0 
#   		if !(board.payment_detail.nil?)
#   			pd = payment_details.build(:amount => width*height)
#   			pd.user = user
#   		end
  	end
  	
  	def create_tiles
	  	for x in x_location..(x_location + width - 1) do 
	  		for y in y_location..(y_location + height - 1) do
	  			@tile = board.tiles.where(:x_location => x, :y_location => y).first
	  			if @tile.nil?
		  			@tile = tiles.build(:x_location => x, :y_location => y)
		  			@tile.cost = 0
		  		else
		  			previous_cost = @tile.cost
		  			@tile.destroy
		  			@tile = tiles.build(:x_location => x, :y_location => y)
		  			new_cost = 2 * previous_cost
		  			if new_cost < 1
		  				new_cost = 1
		  			end
		  			new_cost = new_cost.to_f
		  			@tile.cost = new_cost
		  		end
	  		end
	  	end
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
