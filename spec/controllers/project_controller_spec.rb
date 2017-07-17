require_relative '../spec_helper.rb'

describe 'project controller' do

  describe 'GET /projects' do
    let (:user) do
      User.create(email: 'someone@mail.com', first_name: 'Someone', last_name: 'Smith', password: '123')
    end

    it 'displays a form for the user to create a new project' do
      get '/projects'

      expect(last_response.body).to include('<form')
      expect(last_response.body).to include('</form>')
      expect(last_response.body).to include('name')
      expect(last_response.body).to include('description')
      expect(last_response.body).to include('start_date')
      expect(last_response.body).to include('end_date')
    end
  end

  describe 'POST /projects' do
    let (:user) do
      User.create(email: 'someone@mail.com', first_name: 'Someone', last_name: 'Smith', password: '123')
    end

    it 'stores the user created project in the db' do
      sign_in(user)
      params = { name: 'First Project', description: 'Awesome', start_date: '09/09/1900', end_date: '01/01/2999' }
      post '/projects', params
      follow_redirect!

      expect(last_response.body).to include('Your Projects')
      expect(last_response.body).to include('<a')
      expect(last_response.body).to include('</a>')
      expect(last_response.body).to include('<li')
      expect(last_response.body).to include('</li>')
    end
  end

  describe 'DELETE /projects/:id' do
    let (:user) do
      User.create(email: 'someone@mail.com', first_name: 'Someone', last_name: 'Smith', password: '123')
    end

    it 'deletes a project and removes it from the database' do
      sign_in(user)
      project = Project.create(name: 'First Project', description: 'Awesome', start_date: '09/09/1900', end_date: '01/01/2999')

      expect{ delete "/projects/#{project.id}" }.to change{ Project.count }.by(-1)
    end
  end

  describe 'PUT /projects/:id' do
    let (:user) do
      User.create(email: 'someone@mail.com', first_name: 'Someone', last_name: 'Smith', password: '123')
    end

    it 'allows a user to edit a project' do
      sign_in(user)
      project = Project.create(name: 'First Project', description: 'Awesome', start_date: '09/09/1900', end_date: '01/01/2999')
      params = { name: 'First Project 2.0', description: 'Awesome 2.0', start_date: '09/09/1901', end_date: '02/02/9090' }

      put "/projects/#{project.id}", params
      project.reload

      expect(project.name).to eq('First Project 2.0')
      expect(project.description).to eq('Awesome 2.0')
    end
  end
end
