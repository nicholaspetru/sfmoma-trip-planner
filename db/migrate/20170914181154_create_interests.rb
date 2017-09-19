class CreateInterests < ActiveRecord::Migration[5.0]
  def change
    create_table :interests do |t|
      t.string :user_id
      t.string :artist_slug
      t.string :artwork_slug
      t.timestamps
    end
  end
end
