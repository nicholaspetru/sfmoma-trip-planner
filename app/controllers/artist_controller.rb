require 'httparty'
class ArtistController < ApplicationController
  include HTTParty
  @@api_token = "Token dc21680c717a0cdcd9a5b9047cdc56220fb9d993"
  @@base_url = 'https://www.sfmoma.org/api/collection/artists/'

  def index
    @artists = []
  end

  def show
    @artist_slug = params[:id]
    @artist_data = Artist.make_artist_request(@@base_url + "#{ @artist_slug }")
  end

  def show_artworks
    @artist_slug = params[:id]
    @artist = Artist.make_artist_request(@@base_url + "#{ @artist_slug }")
    @artworks = @artist['artworks'].map do |art|
      Artist.make_artist_request(art['artwork']['url'])
    end
  end

  # def create_artist_interest
  #   @artist_slug = params[:id]
  #   @username = params[:username]
  #   InterestsController.create_interest(@artist_slug, @username, 'artist_slug')
  # end

  def extract_artwork_slug(url)
    if !url.nil? and url.include? 'artworks/'
      return url.partition('artworks/').last
    else
      return nil
    end
  end

  private
  def set_artist
     @artist = Artist.find(params[:id])
   end

   def artist_params
     params.require(:artist).permit(:name, :web_url, :artworks)
   end
end
