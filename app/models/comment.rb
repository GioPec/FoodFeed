class Comment < ActiveRecord::Base
    resourcify
    belongs_to :recipe
end