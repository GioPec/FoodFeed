class RecipesController < ApplicationController

    def new

    end

    def create      #data pubblicazione
        @user = User.find(current_user.id)
        r = Recipe.create(user_id: current_user.id, title: params.require(:recipe).permit(:title)[:title],
            preparazione: params.require(:recipe).permit(:preparazione)[:preparazione],
            image: params.require(:recipe).permit(:image)[:image],
            course: params.require(:recipe).permit(:course)[:course],
            category: params.require(:recipe).permit(:category)[:category],
            intolerance: params.require(:recipe).permit(:intolerance)[:intolerance],
            price: params.require(:recipe).permit(:price)[:price],
            difficulty: params.require(:recipe).permit(:difficulty)[:difficulty],
            time: params.require(:recipe).permit(:time)[:time],
            created_at: DateTime.now, n_likes: 0, n_comments: 0)

        if r.valid?
            current_user.add_role :mod, r
            flash[:notice] = "A recipe from #{@user.username} has been successfully posted!"
            redirect_to user_path(current_user.id)
        else
            flash[:notice] = "Inputs can't be blank"
            redirect_back(fallback_location: root_path)
        end
		
    end

    def show

        @recipe = Recipe.find(params[:id])
    end

    def destroy
        if current_user.has_role? :mod, Recipe.find(params[:id])
            Recipe.delete(params[:id])
            Comment.where(:recipe_id => params[:id]).destroy_all	            
            Like.where(:recipe_id => params[:id]).destroy_all          
            redirect_to user_path(current_user.id)
        else
            flash[:notice] = "You are not allowed to do this"
            redirect_back(fallback_location: root_path)
        end
    end

    def edit
        id = params[:id]
        @recipe = Recipe.find(id)
    end

    def update
        id = params[:id]
        @recipe = Recipe.find(id)
        if @recipe.update_attributes(params.require(:recipe).permit(:title, :preparazione, :course, :category,
             :intolerance, :price, :difficulty, :time))
            redirect_to user_recipe_path(current_user.id, @recipe.id)
        else
            flash[:notice] = "Inputs can't be blank"
            redirect_back(fallback_location: root_path)
        end 
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
        $CU = current_user.id
        @filters=[]
        @recipes = Recipe.all().to_a.reverse
    end

    def updatediscover
        @user = User.find(current_user.id)
        @recipes = Recipe.all()
        @filters = []
        if params.require(:recipe).permit(:course)[:course]!=""
            @recipes = @recipes.where(course: params.require(:recipe).permit(:course)[:course])
            @filters.push("Course: " + params.require(:recipe).permit(:course)[:course])
        end
        if params.require(:recipe).permit(:category)[:category]!=""
            @recipes = @recipes.where(category: params.require(:recipe).permit(:category)[:category])
            @filters.push("Category: "+ params.require(:recipe).permit(:category)[:category])
        end
        if params.require(:recipe).permit(:intolerance)[:intolerance]!=""
            @recipes = @recipes.where(intolerance: params.require(:recipe).permit(:intolerance)[:intolerance])
            @filters.push("Intolerance: " + params.require(:recipe).permit(:intolerance)[:intolerance])
        end
        if params.require(:recipe).permit(:price)[:price]!=""
            @recipes = @recipes.where(price: params.require(:recipe).permit(:price)[:price])
            @filters.push("Price: " + params.require(:recipe).permit(:price)[:price])
        end
        if params.require(:recipe).permit(:difficulty)[:difficulty]!=""
            @recipes = @recipes.where(difficulty: params.require(:recipe).permit(:difficulty)[:difficulty])
            @filters.push("Difficulty: " + params.require(:recipe).permit(:difficulty)[:difficulty])
        end
        @recipes = @recipes.to_a.reverse

        render 'discover.html.erb'
    end

    def like
        id_recipe = params[:recipe_id]
        r = Recipe.find(id_recipe)
        if Like.exists?(user_id: current_user.id, recipe_id: id_recipe)
            flash[:notice] = "You already like this post"
        else
            Like.create!(user_id: current_user.id, recipe_id: id_recipe)
            r.n_likes = r.n_likes+1
            r.save
        end
		redirect_to user_recipe_path(r.user_id, id_recipe)
    end
    
    def remove_like
        id_recipe = params[:recipe_id]
        r = Recipe.find(id_recipe)
        if Like.exists?(user_id: current_user.id, recipe_id: id_recipe)
            @like = Like.where(user_id: current_user.id, recipe_id: id_recipe)
            Like.delete(@like)
            r.n_likes = r.n_likes-1
            r.save
        else
            flash[:notice] = "You cannot dislike a post you don't like"
        end
		redirect_to user_recipe_path(r.user_id, id_recipe)
    end

    def create_comment
        c = Comment.create!(body: params.require(:comment).permit(:body)[:body], user_id: current_user.id, recipe_id: params[:recipe_id], created_at: DateTime.now)
        current_user.add_role :mod, c #role
        redirect_to user_recipe_path(current_user.id, params[:recipe_id])
        r = Recipe.find(params[:recipe_id])
        r.n_comments = r.n_comments+1
        r.save
    end

    def remove_comment  
        u = Comment.find(params[:id]).user_id
        r = Recipe.find(params[:recipe_id])
        if current_user.has_role? :mod, Comment.find(params[:id]) 
            Comment.delete(params[:id])
            r.n_comments = r.n_comments-1
            r.save
        else
            flash[:notice] = "You are not allowed to do this"
        end
        redirect_to user_recipe_path(r.user_id, r.id)
    end

    def favourite
        id_recipe = params[:recipe_id]
        r = Recipe.find(id_recipe)
        if Favourite.exists?(user_id: current_user.id, recipe_id: id_recipe)
            flash[:notice] = "You already have this recipe in your favourites"
        else
            Favourite.create!(user_id: current_user.id, recipe_id: id_recipe)
        end
		redirect_to user_recipe_path(r.user_id, id_recipe)
    end

    def remove_favourite
        id_recipe = params[:recipe_id]
        r = Recipe.find(id_recipe)
        if Favourite.exists?(user_id: current_user.id, recipe_id: id_recipe)
            @favourite = Favourite.where(user_id: current_user.id, recipe_id: id_recipe)
            Favourite.delete(@favourite)
        else
            flash[:notice] = "You don't have this recipe in your favourites"
        end
		redirect_to user_recipe_path(r.user_id, id_recipe)
    end

    def top
        @recipes = Recipe.all().to_a.sort_by{|e| -e[:n_likes]}.first(5)
    end

    def homepage
        following=[]
        @recipes=[]
        all_recipes = Recipe.all().to_a
        f = Follow.where(follower_id: current_user.id)
        f.each do |ff|
            following.push(ff.following_id)
        end
        following.each do |fff|
            all_recipes.each do |r|
                if fff==r.user_id
                    @recipes.push(r)
                end
            end
        end
        
        @recipes=@recipes.reverse

        #@recipes = Recipe.joins(:follow).where(['recipes.user_id = follows.following_id'])
        #@recipes=Recipe.joins(:follow).where(follows: { following_id: admin })

    end
end