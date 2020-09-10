class Favourite < ActiveRecord::Base
    resourcify
    belongs_to :user
    belongs_to :recipe
end
