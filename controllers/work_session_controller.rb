require 'pry'

class App
  get '/work_sessions/new' do
    erb :'/work_sessions/new'
  end

  get '/work_sessions/:id/list_user' do
    authorize!
    work_sessions = WorkSession.where("user_id = ?", current_user.id)
    erb :'work_sessions/list', locals: { work_sessions: work_sessions }
  end
end
