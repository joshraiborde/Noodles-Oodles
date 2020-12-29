class Noodle < ApplicationRecord
  belongs_to :brand
  belongs_to :user #creator of it
  has_many :reviews
  has_many :users, through: :reviews #people who have reviewed it
  # accepts_nested_attributes_for :brand

  validates :flavor, presence: true #use the plural form of validate when using default validators in the model, it is followed by the attributes that are being validated
  validate :not_a_duplicate #use the singular form of validate when using custom validators in the model, it is followed by the sub-methods created to validate attributes
  
  def brand_attributes=(attributes)
    brand = Brand.find_or_create_by(attributes) if !attributes['name'].empty?
  end

  def not_a_duplicate
    #if there is already a pack of noodles with that flavor && brand, throw an error
    if Noodle.find_by(flavor: flavor, brand_id: brand_id)
      errors.add(:flavor, "has already been added to that brand")
    end
  end

  def flavor_and_brand
    "#{flavor} - #{brand.name}"
  end


end
