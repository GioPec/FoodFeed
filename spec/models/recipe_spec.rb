require "rails_helper"

RSpec.describe Recipe, type: :model do
  describe "Creating a Recipe" do
    it "should be permitted" do
      
      @user = FactoryBot.create(:user)
      
      recipe = Recipe.new(title: 'Recipe', 
                              preparazione: 'Preparation',
                              image: '../support/test_image.jpg',
                              user_id: @user.id,
                              n_likes: 0,
                              n_comments: 0,
                              created_at: Time.now.utc)
      expect(recipe).to be_valid

      @user.destroy
    end
  end
end
