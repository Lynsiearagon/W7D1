class SessionsController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_creds(params[:user][:username], params[:user][:password])
        # verify username and password
        if @user
            # reset user session_token
            self.reset_session_token!
            # updates session hash with new session token
            login!(@user)
            # redirect user to cats index page
            redirect_to cats_url
        else
            redirect_to new_session_url
        end

    end

    def destroy
        # will do this in the next section
    end
end
