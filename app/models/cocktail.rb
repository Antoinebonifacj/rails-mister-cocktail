class Cocktail < ApplicationRecord
  has_many :doses
  has_many :ingredients, through: :doses

  validates :name, presence: true, uniqueness: true
end
