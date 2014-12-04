enable :sessions
# Homepage (Root path)

helpers do
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

get '/' do
  erb :index
end

get '/tracks' do
  @tracks = Track.order(upvotes: :desc)
  erb :'tracks/index'
end

get '/tracks/new' do
  erb :'tracks/new'
end

get '/tracks/:id' do
  @track = Track.find params[:id]
  @comments = @track.comments.order(created_at: :desc)
  erb :'tracks/show'
end

post '/track/:id/comments' do
  @comment = Comment.new(
    user_id: current_user.id,
    track_id: params[:id],
    comment_body: params[:comment_body]
    )
  if @comment.save!
    redirect "/tracks/#{@comment.track_id}"
  else
    erb :'/track'
  end
end

post '/tracks' do
  @track = Track.new(
    song_title: params[:song_title],
    artist: params[:artist],
    author:  params[:author] || current_user.username,
    url: params[:url]
  )
  if @track.save!
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

post '/tracks/:track_id/upvotes' do
  if Vote.where(track_id: params[:track_id], user_id: session[:user]).empty?
    Vote.create(track_id: params[:track_id], user_id: session[:user])
    @track = Track.find(params[:track_id])
    @track.upvotes = Vote.where(track_id: params[:track_id]).count
    @track.save
    redirect '/tracks'
  else
    redirect '/tracks'
  end
end

get '/login' do
  erb :'login/login'
end

post '/login' do
  username = params[:username]
  password = params[:password]
  user = User.where(username: username, password: password).first
  if user
    session[:user] = user.username
    session[:user_id] = user.id
    redirect '/'
  else
    redirect '/login'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

post '/signup' do
  @user = User.new(username: params[:username], email: params[:email], password: params[:password])
  if @user.save
    session[:user_id] = @user.id
    redirect '/'
  else
    redirect '/signup'
  end

  
end

