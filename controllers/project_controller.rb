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

  get '/projects/:id/edit' do
    project = Project.find_by(id: params[:id])
    erb :'projects/edit', locals: { project: project }
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

  put '/projects/:id' do
    project = Project.find_by(id: params[:id])
    project.update_attributes(name: params[:name], description: params[:description], start_date: params[:start_date], end_date: params[:end_date])
    erb :'/projects/view', locals: { project: project }
  end

  delete '/projects/:id' do
    project = Project.find_by(id: params[:id])
    project.destroy
    redirect "/projects/#{current_user.id}/list"
  end

end
