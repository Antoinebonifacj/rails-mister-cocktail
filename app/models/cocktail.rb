class Cocktail < ApplicationRecord
  has_one_attached :photo
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses

  validates :name, presence: true, uniqueness: true
end
