require 'pry'

class App
  get '/' do
    erb :'home/index'
  end

  get '/register' do
    erb :'home/register'
  end

  get '/login' do
    erb :'home/login'
  end

  post '/register' do
    user = User.new(params)
    if user.save
      redirect "user/#{user.id}/sessions"
    else
      erb :'home/register'
    end
  end

  post '/login' do
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])

    if user
      session[:user_id] = user.id
      redirect "user/#{user.id}/sessions"
    end

  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
