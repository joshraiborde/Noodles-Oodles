class Noodle < ApplicationRecord
  belongs_to :brand
  belongs_to :user #creator of it
  has_many :reviews
  has_many :users, through: :reviews #people who have reviewed it
  # accepts_nested_attributes_for :brand

  validates :flavor, presence: true #use the plural form of validate when using default validators in the model, it is followed by the attributes that are being validated
  validate :not_a_duplicate #use the singular form of validate when using custom validators in the model, it is followed by the sub-methods created to validate attributes

  scope :order_by_rating, -> {left_joins(:reviews).group(:id).order('avg(stars) desc')}

  def self.alpha
    order(:flavor)
  end
  
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

  #scope methods are defined to be in the models
  #scope methods are typically called in the controllers
  #sometimes, scope methods are called in the view
  #if you want to change the way something is displayed, you can call a scope method in the views, if you're only going to use it once in the view

end
