class SlugsController < ApplicationController
  @@base_url = 'https://www.sfmoma.org/api/collection/artists/'

  def index

    @current_artists_slugs = Slug.build_slug_list([], @@base_url)
    if @current_artists_slugs
      @slug_list = @current_artists_slugs[0].sort
      @next_url = extract_page_number(@current_artists_slugs[1])
      @prev_url = extract_page_number(@current_artists_slugs[2])
    end
  end

  def show
    request_url = @@base_url + "?page=#{ params[:id] }"
    @current_artists_slugs = Slug.build_slug_list([], request_url)
    if @current_artists_slugs
      @slug_list = @current_artists_slugs[0].sort
      @next_url = extract_page_number(@current_artists_slugs[1])
      @prev_url = extract_page_number(@current_artists_slugs[2])
    end
  end

  def extract_page_number(url)
    if !url.nil? and url.include? '?page='
      return url.partition('?page=').last
    else
      return nil
    end
  end
end
