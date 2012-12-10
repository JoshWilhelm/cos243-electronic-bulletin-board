class AdvertisementsController < ApplicationController
	before_filter :signed_in_user, only: [:new, :create]
	
	def new
		@board = Board.find(params[:board_id])
		@advertisement = Advertisement.new()
	end

	def create
		@board = Board.find(params[:board_id])
		@advertisement = @board.advertisements.build(params[:advertisement])
		@advertisement.user = current_user
		if !params[:upload].blank?
			@advertisement.image = @advertisement.image_contents.read()
		end
		if @advertisement.save
			flash[:success] = "New advertisement created!"
			redirect_to @board
		else
			render 'new'
		end
	end
	
	def index
        @board = Board.find(params[:board_id])
    end
end