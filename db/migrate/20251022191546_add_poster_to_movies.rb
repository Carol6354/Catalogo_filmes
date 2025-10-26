class AddPosterToMovies < ActiveRecord::Migration[8.0]
  def change
    add_column :movies, :poster, :string
  end
end
