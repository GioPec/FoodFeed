class Follow < ActiveRecord::Base
    resourcify
    belongs_to :user, optional: true

end
