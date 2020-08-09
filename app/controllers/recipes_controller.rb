class RecipesController < ApplicationController

    def new

    end

    def create
        @user = User.find(current_user.id)
		@recipe = @user.recipes.create!(params.require(:recipe).permit(:title, :preparazione, :img))
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
end