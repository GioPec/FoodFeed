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

    validate :acceptable_image
    def acceptable_image
        return unless image.attached?

        unless image.byte_size <= 30.megabyte
          errors.add(:image, "is too big")
        end

        acceptable_types = ["image/jpeg", "image/png", "image/jpg"]
        unless acceptable_types.include?(image.content_type)
          errors.add(:image, "must be a JPEG or PNG")
        end
    end
end