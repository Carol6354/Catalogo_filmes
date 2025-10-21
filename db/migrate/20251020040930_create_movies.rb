class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :genre
      t.integer :year
      t.float :rating

      t.timestamps
    end
  end
end
