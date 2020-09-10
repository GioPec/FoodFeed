class Notification < ActiveRecord::Base
    resourcify
    belongs_to :user
    belongs_to :recipe, optional: true
end
