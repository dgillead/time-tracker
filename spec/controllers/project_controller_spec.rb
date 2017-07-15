require_relative '../spec_helper.rb'
require 'pry'
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

  it 'displays information for an individual project' do
    project = Project.create(name: 'Another Awesome Project', description: 'idk', start_date: '01/01/1989', end_date: '01/01/2000')
    get "/projects/#{project.id}/view"
    expect(last_response.body).to include('Another Awesome Project')
    expect(last_response.body).to include('idk')
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
end
