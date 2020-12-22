class SessionsController < ApplicationController
    def welcome
        
    end

    def destroy
        session.delete(:user_id)
        redirect_to '/'
    end

    def new

    end

    def create
        #Try to tfind the user in our system?
        @user = User.find_by(username: params[:user][:username]) #find_by doesn't show an error
#        #did we find someone & did tey put in the right password
        # if @user && @user.authenticate(params[:user][:password])

        if @user.try(:authenticate, params[:user][:password])
            session[:user_id] = @user.id #log in the user,store the user in session
            redirect_to user_path(@user) #redirect them to the user_path
            else
                flash[:error] = "Sorry, Username and/or Password was wrong. Please try again"
                redirect_to login_path
        end
    end
end
