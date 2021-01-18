class HotelsController < ApplicationController

    def new
        @hotel = Hotel.new
        @hotel.build_location
    end

    def create
        @hotel = Hotel.new(hotel)
        @hotel.user_id = session[:user_id]
        if @hotel.save
            redirect_to hotel_path(@hotel)
        else
            render :new
        end
    end

    private

    def hotel_params
        params.require(:hotel).permit(:name, :price, :free_wifi, :free_breakfast, location.attributes: [:city, :state])
    end
end
