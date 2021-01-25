module RatingsHelper

    def display_header
        if params[:hotel_id]
            content_tag(:h2, "Add a Rating")
        else
            content_tag(:h2, "Create a rating")
        end
    end
end
