class RegistrationsController < ApplicationController
    def new
        #instance variable (@) means that it is viewable in 'views'
        @user = User.new
    end

    def create
        #dynamic - wharever we get from the browser we use for that data
        @user = User.new(user_params)
        if @user.save
            #sesion cookie is encrytped so can't be modified
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Succesfully created account"
        else
            #go to app -> views -> new.html.erb
            render :new
        end
    end

    private
    def user_params
        #will raise error if user not found as a key, and permit = these are the only things we want them to add
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end