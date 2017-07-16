require 'pry'

class App
  get '/work_sessions' do
    erb :'/work_sessions/new'
  end

  get '/work_sessions/:id/list_user' do
    authorize!
    work_sessions = WorkSession.where("user_id = ?", current_user.id)
    erb :'work_sessions/list', locals: { work_sessions: work_sessions }
  end

  get '/work_sessions/:id/list_project' do
    work_sessions = WorkSession.where("project_id = ?", current_project.id)
    erb :'work_sessions/list', locals: { work_sessions: work_sessions }
  end

  post '/work_sessions' do
    binding.pry
    work_session = current_project.work_sessions.new(params)
    binding.pry
    if work_session.save
      redirect "work_sessions/#{current_project.id}/list_project"
    else
      erb :'work_sessions/new'
    end
  end
end
