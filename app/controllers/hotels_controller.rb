class HotelsController < ApplicationController
    before_action :redirect_if_not_logged_in, only: [:show, :new, :create]
   
    def index
        if params[:q] && !params[:q].empty?
            @hotels = Hotel.search(params[:q].downcase) 
        elsif params[:filter] && params[:filter] == "High to Low Price"
            @hotels = Hotel.high_to_low_price 
        elsif params[:filter] && params[:filter] == "Low to High Price"
            @hotels = Hotel.low_to_high_price 
        elsif params[:filter] && params[:filter] == "Most Rated"
            @hotels = Hotel.most_rated
        else
            @hotels = Hotel.all
        end

    end

    def show
        @hotel = Hotel.find_by_id(params[:id])
    end

    def new
        @hotel = Hotel.new
        @hotel.build_location
    end

    def create
        @hotel = Hotel.new(hotel_params)
        @hotel.user_id = session[:user_id]
        if @hotel.save
            redirect_to hotel_path(@hotel)
        else
            @hotel.build_location
            render :new
        end
    end

    private

    def hotel_params
        params.require(:hotel).permit(:name, :price, :free_wifi, :free_breakfast, :location_id, location_attributes: [:city, :state])
    end
end
