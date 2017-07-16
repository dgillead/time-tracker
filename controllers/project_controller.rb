require 'pry'

class App
  get '/projects' do
    erb :'projects/new'
  end

  get '/projects/:id/list' do
    projects = Project.where("user_id = ?", current_user.id)
    erb :'projects/list', locals: { projects: projects }
  end

  get '/projects/:id/view' do
    project = Project.find_by(id: params[:id])
    erb :'projects/view', locals: { project: project }
  end

  post '/projects' do
    authorize!
    project = current_user.projects.new(params)
    if project.save
      redirect "projects/#{current_user.id}/list"
    else
      erb :'projects/new'
    end
  end

  delete '/projects/:id' do
    project = Project.find_by(id: params[:id])
    project.destroy
    redirect "/projects/#{current_user.id}/list"
  end

end
