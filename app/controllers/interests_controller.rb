class InterestsController < ApplicationController
  @@base_url = 'https://www.sfmoma.org/api/collection/'

  def index
    @interests = Interest.all.sort_by(&:user_id)
  end

  def show
    @interest = Interest.find(params[:id])
    @user = User.find_by(username: @interest.user_id)
    @users = User.all
    @interest_link = link_to_interest(@interest['artwork_slug'], @interest['artist_slug'])
    @interest_link_text = @interest['artist_slug'].nil? ? 'artwork' : 'artist'
  end

  def link_to_interest(artwork_slug, artist_slug)
    if artist_slug.nil? or artist_slug.empty?
      return "/artwork/#{ artwork_slug }"
    else
      return "/artist/#{ artist_slug }"
    end
  end

  def new
    @interest = Interest.new
    @type = params[:type]
    @slug = params[:slug]
    @slug = @slug.tr('_','.') unless @type == 'artist_slug'
    @label = get_label(@type, @slug)
  end

  def get_label(type, slug)
    if 'artist_slug' == type
      @data = Artist.make_artist_request(@@base_url + "artists/#{ slug }")
      @label = @data['name']['display']
    else
      @data = Artwork.get_artwork(@@base_url + "artworks/#{ slug }/")
      @label = @data['title']['display']
    end
    @label
  end

  def create_interest
    @type = params[:type]
    @slug = params[:slug]
    @interest = Interest.new(interest_params)
    @interest[@type] = @slug

    respond_to do |format|
      if @interest.save
        format.html { redirect_to @interest, notice: 'Interest created.' }
        format.json { render :show, status: :created, location: @interest }
      else
        format.html { render :new }
        format.json { render json: @interest.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @interest = Interest.new(interest_params)

    respond_to do |format|
      if @interest.save
        format.html { redirect_to @interest, notice: 'User created.' }
        format.json { render :show, status: :created, location: @interest }
      else
        format.html { render :new }
        format.json { render json: @interest.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    helper_method :get_label
    def set_interest
      @interest = Interest.find(params[:id])
    end

    def interest_params
      params.require(:interest).permit(:user_id, :artist_slug, :artwork_slug)
    end
end
