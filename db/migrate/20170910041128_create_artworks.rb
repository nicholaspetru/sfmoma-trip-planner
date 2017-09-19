class CreateArtworks < ActiveRecord::Migration[5.0]
  def change
    create_table :artworks do |t|
      t.string :web_url
      t.string :title
      t.string :images
      t.string :artists
      t.string :style
      t.string :technique
      t.string :description
      t.string :location_code
      t.string :object_keywords
      t.string :date
      t.timestamps
    end
  end
end
