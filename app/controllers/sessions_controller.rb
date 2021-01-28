class SessionsController < ApplicationController
   
    def destroy
        session.delete(:user_id)
        redirect_to '/'
    end

    def new
    end

    def create
        @user = User.find_by(email: params[:user][:email])
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            flash[:error] ="Wrong email or password. Please try again!!"
            redirect_to login_path
        end
    end

    def omniauth
        @user = User.create_from_omnioath(auth)
        if @user.valid?
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            flash[:error] = @user.errors.full_messages.join(", ")
            redirect_to login_path
        end
    end

    private 

    def auth
        request.env['omniauth.auth']
    end
end 