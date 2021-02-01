class RatingsController < ApplicationController

    before_action :set_rating, only: [:show, :edit, :update, :destroy]
    before_action :redirect_if_not_logged_in, only: [:new, :create]
    before_action :redirect_if_not_authorized, only: [:edit, :update, :destroy]

    def new
        if set_hotel
            @rating = @hotel.ratings.build
        else
            @rating = Rating.new
        end
    end

    def index
        if set_hotel
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
    end

    def edit  
    end

    def update    
        if @rating.update(rating_params)
            redirect_to rating_path(@rating)
        else
            render :edit
        end
    end

    def destroy  
        @rating.destroy
        redirect_to ratings_path
    end

    private

    def set_hotel
        @hotel= Hotel.find_by_id(params[:hotel_id])
    end

    def set_rating
        @rating = Rating.find_by_id(params[:id])
    end

    def redirect_if_not_authorized
        if !@rating || @rating.user != current_user
            flash[:error] = "You are not authorized!!"
            redirect_to ratings_path
        end
    end

    def rating_params
        params.require(:rating).permit(:hotel_id, :stars, :description)
    end
end
