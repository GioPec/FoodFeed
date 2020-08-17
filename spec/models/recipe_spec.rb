require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe "Creating a Recipe with an invalid title" do
    it "shouldn't be permitted" do
      recipe = Recipe.create(title: 'ciao', 
                              preparazione: 'pasta e pentole',
                              image: '../support/test_image.jpg')
      expect(recipe).to raise_error(ActiveSupport::MessageVerifier::InvalidSignature)
    end
  end
end
