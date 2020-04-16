# frozen_string_literal: true

class Dose < ApplicationRecord
  belongs_to :cocktail
  belongs_to :ingredient
  validates :measure, presence: true
  validates :ingredient, presence: true
  validates :cocktail, uniqueness: { scope: :ingredient }, presence: true
end
