require 'pry'

class App
  get '/' do
    erb :'home/index'
  end

  get '/register' do
    status_message = ''
    erb :'home/register', locals: { status_message: status_message }
  end

  get '/login' do
    status_message = ''
    erb :'home/login', locals: { status_message: status_message }
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  post '/register' do
    user = User.new(params)
    if user.save
      redirect '/login'
    else
      status_message = 'Please ensure all fields are filled out correctly.'
      erb :'home/register', locals: { status_message: status_message }
    end
  end

  post '/login' do
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])

    if user
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    else
      status_message = 'Incorrect email or password.'
      erb :'home/login', locals: { status_message: status_message }
    end
  end

  def authorize!
    redirect "/login" unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_project
    @current_project ||= Project.find_by(id: session[:project_id])
  end
end
