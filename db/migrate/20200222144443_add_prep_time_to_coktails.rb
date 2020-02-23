class AddPrepTimeToCoktails < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :prep_time, :integer
  end
end
