class PasswordResetsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:email])

        if @user.present?
            # send email
            # go to password mailer, send the reset email (include parameters so know who to send to). Deliver later in a background job whenever finished
            PasswordMailer.with(user: @user).reset.deliver_later
        end
        redirect_to root_path, notice: "If an account with that email was found, we have sent a link to reset your password."
    end

    def edit
        # signed will take token from url and look that up, confirm token not over 15min old
        # ! will throw error when it can't find token
        @user = User.find_signed!(params[:token], purpose: "password reset")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
        redirect_to sign_in_path, alert: "Your token has expired. Please try again."
    end

    def update
        @user = User.find_signed!(params[:token], purpose: "password reset")
        if @user.update(password_params)
            redirect_to sign_in_path, notice: "Your password was reset successfully. Please sign in"
        else
            render :edit
        end
    end

    private

    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end