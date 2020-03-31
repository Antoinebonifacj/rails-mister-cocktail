class CreateGlasses < ActiveRecord::Migration[5.2]
  def change
    create_table :glasses do |t|
      t.string :name

      t.timestamps
    end
  end
end
