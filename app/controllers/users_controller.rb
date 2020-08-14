class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def show
        id = params[:id]
        if User.exists?(id)
            @user = User.find(id)
        else
            flash[:notice] = "User does not exist"
        end

        @user = User.find(@user.id)
        @n_recipe = Recipe.where(:user_id => Integer(params[:id])).length
    end
    
    def disable
        if current_user.has_role? :mod, User.find(params[:id])
            u=User.find(params[:id])
            u.disabled = true
            u.save
            redirect_to users_path
        else
            flash[:notice] = "You are not allowed to do this"
            redirect_to users_path
        end
    end

    def enable
        if current_user.has_role? :mod, User.find(params[:id])
            u=User.find(params[:id])
            u.disabled = false
            u.save
            redirect_to users_path
        else
            flash[:notice] = "You are not allowed to do this"
            redirect_to users_path
        end
    end

    def disabled
        
    end
end
