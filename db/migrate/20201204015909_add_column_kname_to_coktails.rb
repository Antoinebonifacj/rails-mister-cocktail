class AddColumnKnameToCoktails < ActiveRecord::Migration[5.2]
  def self.up
    #Code to migrate 
    add_column :cocktails, :kname, :string
    Cocktail.all.each do |cok|
      cok.update(kname: cok.name.parameterize.underscore)
    end
  end

  def self.down
    remove_column :cocktails, :kname
  end
end
