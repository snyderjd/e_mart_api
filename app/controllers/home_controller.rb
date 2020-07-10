class HomeController < ApplicationController
    # authenticate_user is now a resource you can use on any method to make sure the client is authorized
    before_action :authenticate_user, only: [:auth]

    def index
        render json: { service: 'auth-api', status: 200 }
    end

    # Authorized only method
    def auth
        render json: { status: 200, msg: "You are currently logged in as #{current_user.first_name} #{current_user.last_name}"}
    end
end

