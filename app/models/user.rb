class User < ApplicationRecord
    has_many :reviews
    has_many :reviewed_noodles, through: :reviews, source: :noodle

    has_many :noodles #that they have created 

    validates :username, uniqueness: true, presence: true

    has_secure_password


end
