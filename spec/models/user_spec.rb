require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Creating a User with an invalid email" do
    it "shouldn't be permitted" do
      user = User.create(email: 'user',
                   password: 'password1234',
                   password_confirmation: 'password1234',
                   username: 'user1234',
                   first_name: 'user',
                   last_name: '1234')
      expect(user).to_not be_valid
    end
  end

  describe "Creating a User with an invalid username" do
    it "shouldn't be permitted" do
      user = User.create(email: 'user@mail.it',
                   password: 'password1234',
                   password_confirmation: 'password1234',
                   username: nil,
                   first_name: 'user',
                   last_name: '1234')
      expect(user).to_not be_valid
    end
  end

  describe "Creating a User with an invalid first name" do
    it "shouldn't be permitted" do
      user = User.create(email: 'user@mail.it',
                   password: 'password1234',
                   password_confirmation: 'password1234',
                   username: 'user1234',
                   first_name: nil,
                   last_name: '1234')
      expect(user).to_not be_valid
    end
  end

  describe "Creating a User with an invalid last name" do
    it "shouldn't be permitted" do
      user = User.create(email: 'user@mail.it',
                   password: 'password1234',
                   password_confirmation: 'password1234',
                   username: 'user1234',
                   first_name: 'user',
                   last_name: nil)
      expect(user).to_not be_valid
    end
  end

  describe "Creating a User with password and password confirmation not matching" do
    it "shouldn't be permitted" do
      user = User.create(email: 'user@mail.it',
                   password: 'password1234',
                   password_confirmation: 'wrong_password',
                   username: 'user1234',
                   first_name: 'user',
                   last_name: '1234')
      expect(user).to_not be_valid
    end
  end

  describe "Creating a User with a password shorter than 8 characters" do
    it "shouldn't be permitted" do
      user = User.create(email: 'user@mail.it',
                   password: '1234',
                   password_confirmation: '1234',
                   username: 'user1234',
                   first_name: 'user',
                   last_name: '1234')
      expect(user).to_not be_valid
    end
  end

end
