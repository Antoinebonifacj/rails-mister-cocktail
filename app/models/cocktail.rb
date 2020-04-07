# frozen_string_literal: true

# Core of the App
class Cocktail < ApplicationRecord
  # Database Relations
  belongs_to :category
  belongs_to :glass
  belongs_to :alcoholic
  has_one_attached :photo
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses

  # Validations
  validates :name, presence: true, uniqueness: true
end
