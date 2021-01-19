class HotelsController < ApplicationController

    def index
        @hotels = Hotel.all
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
            render :new
        end
    end

    private

    def hotel_params
        params.require(:hotel).permit(:name, :price, :free_wifi, :free_breakfast, :location_id, location_attributes: [:city, :state])
    end
end
