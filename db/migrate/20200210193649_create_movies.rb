class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :movie_overview
      t.float :vote_count
      t.string :porter_path
      t.date :release_date

      t.timestamps
    end
  end
end
