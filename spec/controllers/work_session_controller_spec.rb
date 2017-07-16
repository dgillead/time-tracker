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
      sign_in(user)
      params = { date: '01/01/1900', description: 'ok', start_time: '01:01:01:AM', end_time: '02:02:02:AM', is_billable: true, project_name: 'First Project'}

      expect{ post '/work_sessions', params }.to change{ WorkSession.count }.by(1)
    end
  end

  describe 'GET /work_sessions/:id/view' do
    let (:user) do
      User.create(email: 'someone@mail.com', first_name: 'Someone', last_name: 'Smith', password: '123')
    end
    let (:project) do
      Project.create(name: 'First Project', description: 'Awesome', start_date: '09/09/1900', end_date: '01/01/2999')
    end
    let (:work_session) do
      WorkSession.create(date: '01/01/1900', description: 'Stuff', start_time: '01:01:01:AM', end_time: '02:02:02:AM', is_billable: true, project_name: 'First Project')
    end

    it 'displays the details for the current work session' do
      get "work_sessions/#{work_session.id}/view"

      expect(last_response.body).to include('Stuff')
      expect(last_response.body).to include('First Project')
    end
  end
end
