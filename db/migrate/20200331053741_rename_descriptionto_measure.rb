class RenameDescriptiontoMeasure < ActiveRecord::Migration[5.2]
  def change
    rename_column :doses, :description, :measure
  end
end
