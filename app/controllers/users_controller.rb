class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create 
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end

    end

    def edit
        set_user
        redirect_if_not_authorized
    end

    def update
        set_user
        if @user.update(params.require(:user).permit(:name, :password))
            redirect_to user_path(@user)
         else
            render :edit 
        end
    end

    def show
        @user = User.includes(hotels: :ratings).find_by_id(params[:id])
        @user_hotels = Hotel.where(user_id: @user.id)
        redirect_if_not_authorized
        redirect_to user_path(@user) if !@user
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password)
    end

    def redirect_if_not_authorized
        if !@user || @user != current_user
            render :invalid
        end
    end

    def set_user
        @user = User.find_by_id(params[:id])
    end
end
