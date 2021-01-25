class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create 
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to '/'
        else
            render :new
        end

    end


    def show
        @user = User.includes(hotels: :ratings).find_by_id(params[:id])
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
end
