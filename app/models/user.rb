class User < ApplicationRecord
  has_many :artist
  has_many :artwork
  has_many :interest
end
