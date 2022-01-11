class OmniauthCallbacksController < ApplicationController
    def twitter
        # check if database has query with this username, if it does give me the first one with that username, otherwise give me a new account with that username asigned
        twitter_account = Current.user.twitter_accounts.where(username: auth.info.nickname).first_or_initialize
        twitter_account.update(
            name: auth.info.name,
            username: auth.info.nickname,
            image: auth.info.image,
            token: auth.credentials.token,
            secret: auth.credentials.secret,
        )
        

        redirect_to root_path, notice: "Successfully connected your account"
    end
    
    # gives us the hash of credentials back from twitter
    def auth
        request.env['omniauth.auth']
    end    
end