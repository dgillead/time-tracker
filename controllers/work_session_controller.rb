require 'pry'

class App
  get '/work_sessions' do
    projects = Project.all
    erb :'/work_sessions/new', locals: { projects: projects}
  end

  get '/work_sessions/:id/list_user' do
    authorize!
    work_sessions = WorkSession.where("user_id = ?", current_user.id)
    erb :'work_sessions/list', locals: { work_sessions: work_sessions }
  end

  post '/work_sessions' do
    work_session = WorkSession.new(params)
    work_session[:user_id] = current_user.id
    if work_session.save
      redirect "work_sessions/#{current_user.id}/list_user"
    else
      erb :'work_sessions/new'
    end
  end
end
