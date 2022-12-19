class ApplicationController < ActionController::Base

    def login!(user)
        session[:session_token] = self.session_token
    end

end