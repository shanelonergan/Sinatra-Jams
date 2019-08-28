require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  def artists
      @artists = Artist.all
  end

  get "/" do
    erb :welcome
  end

  # INDEX

  get '/artists' do
    if params[:search_name]
      @artists = artists.where("name LIKE ?", "%#{params[:search_name]}%")
    else
      @artists = artists
    end
    erb :index
  end

  # NEW
  get '/artists/new' do
    erb :new
  end

  # CREATE
  post "/artists" do

    @artist = Artist.create(params[:artist])
    redirect "/artists/#{@artist.id}"
  end

  # SHOW
  get '/artists/:id' do
    @artist = Artist.find(params[:id])
    erb :show
  end

  # EDIT ACTION
  get '/artists/:id/edit' do
    @artist = Artist.find(params[:id])
    erb :edit
  end

  # UPDATE action
  patch '/artists/:id' do
    # binding.pry
    @artist = Artist.find(params[:id])
    @artist.update(params[:artist])
    redirect "/artists/#{@artist.id}"
  end

  # Destroy
  delete '/artists/:id' do
    @artist = Artist.find(params[:id])
    @artist.destroy
    redirect "/artists"
  end


end
