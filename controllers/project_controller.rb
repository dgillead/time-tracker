require 'pry'

class App
  get '/projects' do
    erb :'projects/new'
  end

  get '/projects/:id/list' do
    # binding.pry
    projects = Project.where("user_id = ?", current_user.id)
    erb :'projects/list', locals: { projects: projects }
  end

  post '/projects' do
    authorize!
    project = current_user.projects.new(params)
    # binding.pry
    if project.save
      redirect "projects/#{current_user.id}/list"
    else
      erb :'projects/new'
    end
  end

end
