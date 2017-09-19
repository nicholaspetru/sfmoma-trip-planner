require 'httparty'

class Artist < ApplicationRecord
  include HTTParty
  @@api_token = "Token dc21680c717a0cdcd9a5b9047cdc56220fb9d993"
  has_many :user
  has_many :interst
  has_many :artwork

  def self.make_artist_request(request_url)
    return HTTParty.get(request_url, {
      :headers => {
        'Authorization' => @@api_token,
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    })
  end
end
