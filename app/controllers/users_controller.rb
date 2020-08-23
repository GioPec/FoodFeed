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
            if u.has_role? :admin
                flash[:notice] = "You are not allowed to do this"
                redirect_to users_path
            else
                u.disabled = true
                u.save
                redirect_to users_path
            end
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

    def favourites
        @favourites = Favourite.where(user_id: current_user.id)
    end

    def follow
        follower = User.find(params[:follower_id])
        id_following = params[:user_id]
        f = User.find(id_following)
        if Follow.exists?(follower_id: follower.id, following_id: id_following)
            flash[:notice] = "You already follow this user"
            redirect_back(fallback_location: root_path)
        elsif id_following==current_user.id
            flash[:notice] = "You can't follow yourself"
            redirect_back(fallback_location: root_path)
        else
            Follow.create!(follower_id: follower.id, following_id: id_following)
            follower.n_following = follower.n_following+1
            follower.save
            f.n_follower = f.n_follower+1
            f.save
            #notification
            Notification.create!(sender_id: current_user.id, user_id: f.id, notification_type: "follow", read: false)
            redirect_to user_path(id_following)
        end
    end
    
    def unfollow
        follower = User.find(params[:follower_id])
        id_following = params[:user_id]
        f = User.find(id_following)
        if Follow.exists?(follower_id: follower.id, following_id: id_following)
            follow = Follow.where(follower_id: follower.id, following_id: id_following)
            Follow.delete(follow)
            follower.n_following = follower.n_following-1
            follower.save
            f.n_follower = f.n_follower-1
            f.save
            redirect_to user_path(id_following)
        elsif id_following==current_user.id
            flash[:notice] = "You can't follow yourself"
            redirect_back(fallback_location: root_path)
        else
            flash[:notice] = "You already follow this user"
            redirect_back(fallback_location: root_path)
        end
    end

    def follower
        @followers=[]
        f = Follow.where(following_id: params[:user_id])
        f.each do |ff|
            @followers.push(ff.follower_id)
        end
    end

    def following
        @following=[]
        f = Follow.where(follower_id: params[:user_id])
        f.each do |ff|
            @following.push(ff.following_id)
        end
    
    end

    def remove_notification
        id_notification = params[:id]
        puts "***************"
        puts id_notification
        n = Notification.find(id_notification)
        n.read=true;
        n.save;
        if n.notification_type!="follow"
            redirect_to user_recipe_path(n.user_id, n.recipe_id)
        else
            redirect_to user_path(n.user_id)
        end
    end

    def notifications
        user_id = params[:id]
        @all_n = Notification.where(user_id: user_id).reverse
    end
end
