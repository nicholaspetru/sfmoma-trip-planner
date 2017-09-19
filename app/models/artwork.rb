require 'httparty'

class Artwork < ApplicationRecord
  include HTTParty
  @@api_token = "Token dc21680c717a0cdcd9a5b9047cdc56220fb9d993"
  has_many :user
  has_many :artist
  has_many :interest

  def self.get_artwork(request_url)
    return HTTParty.get(request_url, {
      :headers => {
        'Authorization' => @@api_token,
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    })
  end

  def self.get_artwork_name(slug)
    puts slug
    @artwork_data = Artwork.get_artwork("https://www.sfmoma.org/api/collection/artworks/#{slug}/")
    return @artwork_data['title']['display']
  end

  def self.query_artist(artist_name)
    response = HTTParty.get("https://www.sfmoma.org/api/collection/artworks/#{ artist_name }", :headers => { "Authorization" => "Token dc21680c717a0cdcd9a5b9047cdc56220fb9d993" })
    response["results"]
  end
end
