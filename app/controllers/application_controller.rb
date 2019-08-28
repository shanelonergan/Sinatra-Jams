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

  get '/artists' do
    if params[:search_name]
      @artists = artists.where("name LIKE ?", "%#{params[:search_name]}%")
    else
      @artists = artists
    end
    erb :index
  end

  get '/artists/new' do
    erb :new
  end

  get '/artists/:id' do
    @artist = artists.find(params[:id])
    erb :show
  end

  post "/artists" do

    @artist = Artist.create(params[:artist])
    redirect "/artists/#{@artist.id}"
  end


end
