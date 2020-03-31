class Cocktail < ApplicationRecord
  belongs_to :category
  belongs_to :glass
  belongs_to :alcoholic
  has_one_attached :photo
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :category, presence: true
  validates :glass, presence: true
  validates :prep_time, presence: true
end
