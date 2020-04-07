# frozen_string_literal: true

class AddDescToCoktails < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :description, :string
  end
end
