class RatingsController < ApplicationController

    def new
        if @hotel = Hotel.find_by_id(params[:hotel_id])
            @rating = @hotel.ratings.build
        else
            @rating = Rating.new
        end
    end

    def index
        if @hotel= Hotel.find_by_id(params[:hotel_id])
            @ratings = @hotel.ratings
        else
            @ratings = Rating.all
        end
    end

    def create
        @rating = current_user.ratings.build(rating_params)
            if @rating.save
                redirect_to rating_path(@rating)
            else
                render :new
            end
    end

    def show
        @rating = Rating.find_by_id(params[:id])
    end

    private

    def rating_params
        params.require(:rating).permit(:hotel_id, :stars, :description)
    end
end
