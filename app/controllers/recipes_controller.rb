class RecipesController < ApplicationController

    def new

    end

    def create      #data pubblicazione
        @user = User.find(current_user.id)
        #@recipe = @user.recipes.create!(params.require(:recipe).permit(:title, :preparazione, :img))
        @recipe = @user.recipes.create!(user_id: current_user.id, title: params.permit(:recipe).require(:title), preparazione: params.permit(:recipe).require(:preparazione),
            img: params.permit(:recipe).require(:img), created_at: DateTime.now, n_likes: 0, n_comments: 0)
		flash[:notice] = "A recipe from #{@user.username} has been successfully posted!"
		redirect_to user_path(current_user.id)
    end

    def show
        @recipe = Recipe.find(params[:id])
    end

    def destroy
        Recipe.delete(params[:id])
        redirect_to user_path(current_user.id)
    end

    def edit
        id = params[:id]
        @recipe = Recipe.find(id)
    end

    def update
        id = params[:id]
        @recipe = Recipe.find(id)
        @recipe.update_attributes!(params.require(:recipe).permit(:title, :preparazione, :img))
        redirect_to user_path(current_user.id)
    end

    def daily
        seed = Date.today.to_s.gsub('-','').to_i
        srand(seed)
        recipe_number = rand(1165539)
        puts(recipe_number)

        #url = "https://api.spoonacular.com/recipes/random?apiKey=" + ENV["SPOONACULAR_KEY"]    #random
        url = "https://api.spoonacular.com/recipes/" + recipe_number.to_s + "/information?apiKey=" + ENV["SPOONACULAR_KEY"]
        @response = JSON.parse(Excon.get(url).body)
    end

    def discover
        @recipes = Recipe.all().to_a.reverse
    end

    def like
        id_recipe = params[:recipe_id]
        r = Recipe.find(id_recipe)
        if Like.exists?(user_id: current_user.id, recipe_id: id_recipe)
            flash[:notice] = "You already like this post"
        else
            Like.create!(user_id: current_user.id, recipe_id: id_recipe)
        end
		redirect_to user_recipe_path(r.user_id, id_recipe)
    end
    
    def remove_like
        id_recipe = params[:recipe_id]
        r = Recipe.find(id_recipe)
        if Like.exists?(user_id: current_user.id, recipe_id: id_recipe)
            @like = Like.where(user_id: current_user.id, recipe_id: id_recipe)
            Like.delete(@like)
        else
            flash[:notice] = "You cannot dislike a post you don't like"
        end
		redirect_to user_recipe_path(r.user_id, id_recipe)
    end

    def create_comment
        Comment.create!(body: params.require(:comment).permit(:body)[:body], user_id: current_user.id, recipe_id: params[:recipe_id], created_at: DateTime.now)
        redirect_to user_recipe_path(current_user.id, params[:recipe_id])
    end
    
end