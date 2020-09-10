class Like < ActiveRecord::Base
    resourcify
    belongs_to :recipe
end