class CreateArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :artists do |t|
      t.string :web_url
      t.string :name
      t.string :artworks
      t.timestamps
    end
  end
end
