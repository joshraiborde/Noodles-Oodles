class Brand < ApplicationRecord
    has_many :noodles
    belongs_to :user
    validates :name, presence: true, uniqueness: true
end
