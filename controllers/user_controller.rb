class App
  get '/users/sessions' do
    erb :'/users/sessions'
  end

  get '/users/:id' do
    user = User.find_by(id: params[:id])
    erb :'/users/view', locals: { user: user }
  end

  post '/users/sessions' do
    filtered_sessions = filter_sessions(params)
    erb :'/users/filtered_sessions', locals: { filtered_sessions: filtered_sessions }
  end

  def filter_sessions(params)
    sessions = WorkSession.where("is_billable = '#{params[:is_billable]}' and date between '#{params[:start_date]}' and '#{params[:end_date]}'")
  end
end
