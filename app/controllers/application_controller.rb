class ApplicationController < ActionController::Base
    include ApplicationHelper

    private
     
    def redirect_if_not_logged_in
        if !logged_in?
                flash[:error] = "You must be logged in to access this section"
            redirect_to login_path
        end
    end
end
