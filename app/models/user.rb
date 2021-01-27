class User < ApplicationRecord
    has_many :reviews
    has_many :reviewed_noodles, through: :reviews, source: :noodle

    has_many :noodles #noodles the user has created 
    has_many :brands
    validates :username, uniqueness: true, presence: true

    has_secure_password


    def self.create_by_google_omniauth(auth)
        self.find_or_create_by(username: auth[:info][:email]) do |u|
            u.uid = auth[:uid]
            u.provider = auth[:provider]
            u.password = SecureRandom.hex
        end
    end
    
      def self.create_by_github_omniauth(auth)
        self.find_or_create_by(username: auth[:info][:nickname] ? auth[:info][:nickname] : auth[:info][:name].parameterize.underscore) do |u|
          u.uid = auth[:uid]
          u.provider = auth[:provider]
          u.password = SecureRandom.hex
        end
      end
end
