class ApplicationController < ActionController::Base

    # private
    helper_method :current_user
    # The helper_method :current_user exposes the current_user method so that it can used in the views.

    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id] #find_by_id won't error out, ||= will only call the database once
        # The current_user method will return the value of current_user if it already exists, and will set the value of current_user to the new_user, and return that value…
        # session[:user_id] is the ID. You are using it to find the user with User.find_by_id(session[:user_id]). 
        # it will find the User using the session[:user_id] which we stored when a user logins successfully
    end
end



