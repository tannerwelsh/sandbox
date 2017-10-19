get '/' do
  # Look in app/views/index.erb
  # artists = File.join(MUSIC_ROOT, params[:path] || '/', '*')

  # all_paths = Dir[artists]

  # @folders = all_paths.select { |path| File.directory? path }
  # @songs = all_paths.select { |path| File.file?(path) }

  @artists = Artist.all

  erb :index
end

get '/artists/:artist_name' do
  @artist = Artist.find_by_name(params[:artist_name])

  erb :artist
end

post '/play' do
  @song = Song.find_by_title(params[:song])

  p @song
  # command = "afplay '#{@song}'"

  # @subprocess_id = spawn command

  erb :play
end
