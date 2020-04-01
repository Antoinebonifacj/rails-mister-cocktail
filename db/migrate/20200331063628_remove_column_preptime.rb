class RemoveColumnPreptime < ActiveRecord::Migration[5.2]
  def change
    remove_column :cocktails, :prep_time, :integer
  end
end
