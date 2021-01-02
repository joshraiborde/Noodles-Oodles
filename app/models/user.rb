class User < ApplicationRecord
    has_many :reviews
    has_many :reviewed_noodles, through: :reviews, source: :noodle

    has_many :noodles #that they have created 

    validates :username, uniqueness: true, presence: true

    has_secure_password


    def self.create_by_google_omniauth(auth)
        self.find_or_create_by(username: auth[:info][:email]) do |u|
            u.password = SecureRandom.hex
        end
    end
    
      def self.create_by_github_omniauth(auth)
        self.find_or_create_by(username: auth[:info][:email]) do |u|
          u.password = SecureRandom.hex
    
        end
      end



end
