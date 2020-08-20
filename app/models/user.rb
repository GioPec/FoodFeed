class User < ApplicationRecord
  resourcify

  after_create :assign_default_role
  def assign_default_role
    self.add_role(:user)
  end

  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

    validates :username, presence: true, uniqueness: { case_sensitive: false }
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, uniqueness: true ##

    has_many :recipes
    has_many :likes
    has_many :comments
    has_many :favourites
    has_many :follows

    has_one_attached :profile_img

    # ROLES = ['Admin', 'Moderator', 'User']

    def self.from_omniauth(auth) 
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        #user.gender = auth.extra.gender
        #user.date_of_birth = auth.info.birthday
        username = auth.info.name
        names = username.split
        user.first_name = names[0]
        user.last_name = names[names.length-1]
        user.username = names[0] + names[names.length-1]
        user.img = auth.info.image
        user.password = Devise.friendly_token[0,20]
      end
    end
  
    def self.new_with_session(params, session) 
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
            end
        end
    end

    def self.search(search)
      if search
        find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
      else
        find(:all)
      end
    end
end
