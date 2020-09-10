require "rails_helper"
RSpec.describe 'routes', :type => :routing do
  
  it "routes /dailyrecipe to the recipes controller" do
    expect(get("/dailyrecipe")).
      to route_to("recipes#daily")
  end

  it "routes /users/:user_id/recipes/:recipe_id/like/new to the recipes controller" do
    expect(:get => "/users/:user_id/recipes/:recipe_id/like/new").
      to route_to(:controller => "recipes", :action => "like", :user_id=>":user_id", :recipe_id=>":recipe_id")
  end

  it "routes /users/:user_id/recipes/:recipe_id/like/new to the recipes controller" do
    expect(:delete => "/users/:user_id/recipes/:recipe_id/like/delete").
      to route_to(:controller => "recipes", :action => "remove_like", :user_id=>":user_id", :recipe_id=>":recipe_id")
  end
end