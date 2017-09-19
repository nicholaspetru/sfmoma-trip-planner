class CreateSlugs < ActiveRecord::Migration[5.0]
  def change
    create_table :slugs do |t|
      t.string :slug
      t.string :artist_link
      t.timestamps
    end
  end
end
