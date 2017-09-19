require 'httparty'
class Slug < ApplicationRecord
  include HTTParty
  @@api_token = "Token dc21680c717a0cdcd9a5b9047cdc56220fb9d993"
  has_many :artist

  def self.get_all_artists(request_url)
    return HTTParty.get(request_url, {
      :headers => {
        'Authorization' => @@api_token,
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    })
  end

  def self.build_slug_list(slug_array, requested_api_url)
    return false if requested_api_url.nil?

    current_response = self.get_all_artists(requested_api_url)
    current_response["results"].each do |api_a|
      api_a["slug"] = api_a["slug"].gsub(/[.,]/, '')
      api_a["slug"] = api_a["slug"].mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').to_s
      slug_array.push(api_a["slug"].unicode_normalize!)
    end
    return [slug_array, current_response["next"], current_response["previous"]]
  end
end
