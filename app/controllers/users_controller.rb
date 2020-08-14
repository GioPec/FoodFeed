class UsersController < ApplicationController

    def index
        if current_user.role!="U"
            @users = User.all
        else
            flash[:notice] = "You are not allowed on this page"
            redirect_back(fallback_location: root_path)
        end
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

    def upgrade
        u=User.find(params[:id])
        u.add_role :mod, Comment
        u.add_role :mod, User
        u.add_role :mod, Recipe
        u.role="M"
        u.save
        redirect_back(fallback_location: root_path)
    end

    def downgrade
        u=User.find(params[:id])
        u.remove_role :mod, Comment
        u.remove_role :mod, User
        u.remove_role :mod, Recipe
        u.role="U"
        u.save
        redirect_back(fallback_location: root_path)
    end

    def contact

    end

    def search
        @user = User.find_by(username: params[:search])
        if @user
            
        else
            render inline: '<center><h1>404 - NOT FOUND</h1><a href="http://localhost:3000">go back</a></center>'
        end
    end
end
