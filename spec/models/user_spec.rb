require "rails_helper"

RSpec.describe User, :type => :model do

  before(:all) do
    @user1 = FactoryBot.create(:user)
  end

  after(:all) do
    @user1.destroy
  end
  
  describe "Creating a User" do

    it "is valid with valid attributes" do
      expect(@user1).to be_valid
    end
    
    it "has a unique username" do
      user2 = build(:user, email: "bob@gmail.com")
      expect(user2).to_not be_valid
    end

    it "is not valid if the username is too long" do
      user2 = build(:user, username: "u"*21)
      expect(user2).to_not be_valid
    end

    it "is not valid if the bio is too long" do
      user2 = build(:user, bio: "b"*600)
      expect(user2).to_not be_valid
    end
    
    it "has a unique email" do
      user2 = build(:user, username: "Bob")
      expect(user2).to_not be_valid
    end
    
    it "is not valid without a password" do 
      user2 = build(:user, password: nil)
      expect(user2).to_not be_valid
    end

    it "is not valid if the password is too short" do
      user2 = build(:user, bio: "p"*7)
      expect(user2).to_not be_valid
    end
    
    it "is not valid without a username" do 
      user2 = build(:user, username: nil)
      expect(user2).to_not be_valid
    end
    
    it "is not valid without an email" do
      user2 = build(:user, email: nil)
      expect(user2).to_not be_valid
    end

    it "is not valid if the profile image has a wrong extension" do
      user2 = build(:user, img: Rack::Test::UploadedFile.new('spec/support/factory_bot.rb'))
      expect(user2).to_not be_valid
    end

  end
end

