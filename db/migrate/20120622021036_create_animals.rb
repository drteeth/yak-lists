class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.string :name
      t.boolean :hair

      t.timestamps
    end
  end
end
