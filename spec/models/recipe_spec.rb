require "rails_helper"

RSpec.describe Recipe, type: :model do

  after(:all) do
    @user.destroy
  end

  before(:all) do
    @user = FactoryBot.create(:user)
  end

  describe "Creating a Recipe" do
    it "should be permitted" do
      recipe = Recipe.new(title: 'Recipe', 
                              preparazione: 'Preparation',
                              image: Rack::Test::UploadedFile.new('spec/support/test_image.jpg', 'image/jpg'),
                              user_id: @user.id,
                              n_likes: 0,
                              n_comments: 0,
                              created_at: Time.now.utc)
      expect(recipe).to be_valid
    end

    it "is not valid without the title" do
      recipe = Recipe.new(title: nil, 
                              preparazione: 'Preparation',
                              image: Rack::Test::UploadedFile.new('spec/support/test_image.jpg', 'image/jpg'),
                              user_id: @user.id)
      expect(recipe).to_not be_valid
    end


    it "is not valid without the preparation" do
      recipe = Recipe.new(title: 'Recipe', 
                              preparazione: nil,
                              image: Rack::Test::UploadedFile.new('spec/support/test_image.jpg', 'image/jpg'),
                              user_id: @user.id)
      expect(recipe).to_not be_valid
    end


    it "is not valid without the image" do
      recipe = Recipe.new(title: 'Recipe', 
                              preparazione: 'Preparation',
                              image: nil,
                              user_id: @user.id)
      expect(recipe).to_not be_valid
    end

    it "is not valid without the user" do
      recipe = Recipe.new(title: 'Recipe', 
                              preparazione: 'Preparation',
                              image: Rack::Test::UploadedFile.new('spec/support/test_image.jpg', 'image/jpg'),
                              user_id: nil)
      expect(recipe).to_not be_valid
    end

    it "is valid without n_likes" do
      recipe = Recipe.new(title: 'Recipe', 
                              preparazione: 'Preparation',
                              image: Rack::Test::UploadedFile.new('spec/support/test_image.jpg', 'image/jpg'),
                              user_id: @user.id,
                              n_likes: nil,
                              n_comments: 0,
                              created_at: Time.now.utc)
      expect(recipe).to be_valid
    end

    it "is valid without n_comments" do
      recipe = Recipe.new(title: 'Recipe', 
                              preparazione: 'Preparation',
                              image: Rack::Test::UploadedFile.new('spec/support/test_image.jpg', 'image/jpg'),
                              user_id: @user.id,
                              n_likes: 0,
                              n_comments: nil,
                              created_at: Time.now.utc)
      expect(recipe).to be_valid
    end
  end
end
