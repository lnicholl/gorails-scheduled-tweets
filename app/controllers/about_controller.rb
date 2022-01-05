# Inherit from ApplicationController to get all rails functionality
class AboutController < ApplicationController

    # index doesn't have to do anything, as it inherits from application controller
    def index
        #by default will look in views -> about folder
    end
end