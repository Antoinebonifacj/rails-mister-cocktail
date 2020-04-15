class AddKnameToCategory < ActiveRecord::Migration[5.2]
  def self.up
    #Code to migrate 
    add_column :categories, :kname, :string
    Category.all.each do |cat|
      cat.update(kname: cat.name.parameterize.underscore)
    end
  end

  def self.down
    remove_column :categories, :kname
  end
end
