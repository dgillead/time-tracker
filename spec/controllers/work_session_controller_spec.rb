require_relative '../spec_helper.rb'

describe 'work session controller' do

  describe 'get worksessions/new' do
    it 'displays a form for the user to create a work session' do
      get '/work_sessions'

      expect(last_response.body).to include('<form')
      expect(last_response.body).to include('</form>')
      expect(last_response.body).to include('description')
      expect(last_response.body).to include('start_time')
      expect(last_response.body).to include('end_time')
    end
  end

  describe 'POST /work_sessions' do
    let (:user) do
      User.create(email: 'someone@mail.com', first_name: 'Someone', last_name: 'Smith', password: '123')
    end
    let (:project) do
      Project.create(name: 'First Project', description: 'Awesome', start_date: '09/09/1900', end_date: '01/01/2999')
    end

    it 'stores the user created work session in the db' do
      project = Project.create(name: 'First Project', description: 'Awesome', start_date: '09/09/1900', end_date: '01/01/2999')
      post '/work_sessions'
      follow_redirect!

      expect(last_response.body).to include('Your Work Sessions')
      expect(last_response.body).to include('<a')
      expect(last_response.body).to include('</a>')
      expect(last_response.body).to include('<li')
      expect(last_response.body).to include('</li>')
    end
  end
end
