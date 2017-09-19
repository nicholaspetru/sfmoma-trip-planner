require 'cgi'

class ArtworkController < ApplicationController
  @@base_url = 'https://www.sfmoma.org/api/collection/artworks/'

  def index
		@artworks = Artwork.image
	end

  def show
    request_url = @@base_url + "#{ params[:id].tr('_','.') }/"
    @artwork = Artwork.get_artwork(request_url)
    @artist = @artwork['artists'][0]['artist'] unless @artwork['artists'].nil?
    @artist_slug = extract_artist_slug(@artist['url'])
  end

  def extract_artist_slug(artist_api_url)
    if !artist_api_url.nil? and artist_api_url.include? 'artists/'
      return artist_api_url.partition('artists/').last
    else
      return nil
    end
  end
end
