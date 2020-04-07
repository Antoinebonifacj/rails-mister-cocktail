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

  # Validations
  validates :name, presence: true, uniqueness: true

  # TODO: Implement the Multi-Search gem
  pg_search_scope :global_search,
  against: [:name, :description ],
  associated_against: {
    glasses: [:name],
    categories: [:name]
  },
  using: {
    tsearch: {any_word: true}
  }
end
