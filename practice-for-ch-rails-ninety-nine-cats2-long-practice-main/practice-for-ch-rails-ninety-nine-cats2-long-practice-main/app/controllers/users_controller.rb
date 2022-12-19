class UsersController < ApplicationController

    def new
        @user = User.new
        render :new 
    end

    def create
        @user = User.new(user_params[:id])

        if @user.save!
            login!(@user)
            redirect_to user_url(@user)
        else 
            render :new
        end

    end


    private

    def user_params
        params.require(:users).permit(:username, :password)
    end
end
