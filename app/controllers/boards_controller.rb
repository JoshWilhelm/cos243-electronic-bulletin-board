class BoardsController < ApplicationController
	before_filter :signed_in_user, only: [:new, :create]

	def show
		@board = Board.find(params[:id])	
	end
	
	def new
		@board = Board.new
	end
	
	def create
		@board = current_user.boards.create(params[:board])
    	if @board.save
    		@advertisement = @board.advertisements.build()
    		@advertisement.x_location = 0
            @advertisement.y_location = 0
            @advertisement.height = @board.height
            @advertisement.width = @board.width
            @advertisement.user = current_user
            @advertisement.save
            flash[:success] = "Board Created"
            redirect_to @board
        else
        	flash[:error] = 'Invalid board info'
        	render 'new'
        end
    end
	
	def index
  		@boards = Board.all
  	end
end
