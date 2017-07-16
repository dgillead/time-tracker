require 'pry'

class App
  get '/work_sessions' do
    projects = Project.all
    erb :'/work_sessions/new', locals: { projects: projects}
  end

  get '/work_sessions/:id/list_user' do
    authorize!
    work_sessions = WorkSession.where("user_id = ?", current_user.id)
    user = current_user
    erb :'work_sessions/list', locals: { work_sessions: work_sessions, user: user  }
  end

  get '/work_sessions/:id/view' do
    work_session = WorkSession.find_by(id: params[:id])
    erb :'work_sessions/view', locals: { work_session: work_session }
  end

  get '/work_sessions/:id/edit' do
    work_session = WorkSession.find_by(id: params[:id])
    erb :'work_sessions/edit', locals: { work_session: work_session }
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

  put '/work_sessions/:id' do
    work_session = WorkSession.find_by(id: params[:id])
    work_session.update_attributes(date: params[:date], description: params[:description], start_time: params[:start_time], end_time: params[:end_time], is_billable: params[:is_billable], project_name: params[:project_name])
    erb :'work_sessions/view', locals: { work_session: work_session }
  end

  delete '/work_sessions/:id' do
    work_session = WorkSession.find_by(id: params[:id])
    work_session.destroy
    redirect "work_sessions/#{current_user.id}/list_user"
  end
end
