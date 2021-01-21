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
        # @user = User.find_or_create_from_auth(auth)
        # self.current_user = @user
        # redirect_to '/'

        if params[:provider] == 'google_oauth2'
            @user = User.create_by_google_omniauth(auth)
            session[:user_id] = @user.id
            redirect_to user_path(@user)
      
          elsif params[:provider] == 'github'
            @user = User.create_by_github_omniauth(auth)
            # byebug
            session[:user_id] = @user.id
            redirect_to user_path(@user)
            
        else

        #Try to find the user in our system?
        @user = User.find_by(username: params[:user][:username]) #find_by doesn't show an error
        #did we find someone & did they put in the right password
        if @user.try(:authenticate, params[:user][:password])
            session[:user_id] = @user.id #log in the user,store the user in session
            redirect_to user_path(@user) #redirect them to the user_path
            else
                flash[:error] = "Sorry, Username and/or Password was wrong. Please try again"
                redirect_to login_path
            end
        end
    end

    def omniauth_google
        @user = User.create_by_google_omniauth(auth)
        session[:user_id] = @user.id
        redirect_to user_path(@user)
                # self.current_user = @user
    end

    private

    def auth 
        request.env['omniauth.auth']
    end
end

