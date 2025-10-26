class AddDetailsToMovies < ActiveRecord::Migration[8.0]
  def change
    add_column :movies, :synopsis, :text
    add_column :movies, :duration, :integer
    add_column :movies, :director, :string
  end
end
