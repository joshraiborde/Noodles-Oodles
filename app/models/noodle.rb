class Noodle < ApplicationRecord
  belongs_to :brand
  belongs_to :user
  has_many :reviews, :dependent => :delete_all
  has_many :users, through: :reviews #users that reviewed noodles

  has_one_attached :image, :dependent => :delete_all

  validates :flavor, presence: true #use the plural form of validate when using default validators in the model, it is followed by the attributes that are being validated
  validate :not_a_duplicate #use the singular form of validate when using custom validators in the model, it is followed by the sub-methods created to validate attributes

  scope :order_by_rating, -> {left_joins(:reviews).group(:id).order('avg(stars) desc')}

  def self.alpha
    order(:flavor)
  end
  
  def brand_attributes=(attributes)
    self.brand = Brand.find_or_create_by(attributes) if !attributes['name'].empty?
    self.brand
  end

  def thumbnail
    self.image.variant(resize: "300x250")
  end

  def cover_thumbnail
    self.image.variant(resize: "500x450")
  end
  def not_a_duplicate
    #if there is already a pack of noodles with that flavor && brand, display an error
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
