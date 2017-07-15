require_relative '../spec_helper.rb'

describe 'project controller' do

  describe 'GET index' do
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
end
