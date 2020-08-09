class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def show
        id = params[:id]
        if User.exists?(id)
            @user = User.find(id)
        else
            render html: 'User does not exit'   #TODO 404
        end

        @user = User.find(@user.id)
        @n_recipe = Recipe.where(:user_id => Integer(params[:id])).length
	end
end
