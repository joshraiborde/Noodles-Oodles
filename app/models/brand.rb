class Brand < ApplicationRecord
    has_many :noodles
    validates :name, presence: true, uniqueness: true
end
