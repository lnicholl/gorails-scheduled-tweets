class ApplicationController < ActionController::Base
    #before_action = before any action in controller eg index, create, destroy...
    before_action :set_current_user
    def set_current_user
    #if user id is in the session
        if session[:user_id]
            #then look up the database user value and assign to instance user variable
            # find_by wil not trhow error when cannot find user by id
            Current.user = User.find_by(id: session[:user_id])
        end
    end

    #redirects user to sign in
    def require_user_logged_in!
        redirect_to sign_in_path, alert: "You must be signed in to do that." if Current.user.nil?
    end
end
