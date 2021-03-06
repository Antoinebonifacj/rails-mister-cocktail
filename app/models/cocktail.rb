# frozen_string_literal: true

# Core of the App
class Cocktail < ApplicationRecord
  include PgSearch::Model
  # Database Relations
  belongs_to :category
  belongs_to :glass
  belongs_to :alcoholic
  has_one_attached :photo
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_many :reviews, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: true

  # TODO: Implement the Multi-Search gem
  pg_search_scope :search_by_name_and_description,
    against: [ :name, :description ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
