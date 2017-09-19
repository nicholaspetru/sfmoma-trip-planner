class Interest < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  belongs_to :artwork
end
