class Recipe < ActiveRecord::Base
    resourcify

    validates :image, presence: true   #verificare
    validates :title, presence: true
    validates :preparazione, presence: true

    belongs_to :user
    has_many :likes
    has_many :comments
    has_many :favourites
    has_many :notifications

    has_one_attached :image

end