class ApplicationController < ActionController::Base

    # private
    helper_method :current_user

    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id] #find_by_id won't error out, ||= will only call the database once, 
    end
end
