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
end
