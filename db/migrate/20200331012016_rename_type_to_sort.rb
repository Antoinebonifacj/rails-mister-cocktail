# frozen_string_literal: true

class RenameTypeToSort < ActiveRecord::Migration[5.2]
  def change
    rename_column :ingredients, :type, :sort
  end
end
