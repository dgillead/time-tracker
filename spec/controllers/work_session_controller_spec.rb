require_relative '../spec_helper.rb'

describe 'work session controller' do
  describe 'get worksessions/new' do
    it 'displays a form for the user to create a work session' do
      get '/work_sessions/new'

      expect(last_response.body).to include('<form')
      expect(last_response.body).to include('</form>')
      expect(last_response.body).to include('description')
      expect(last_response.body).to include('start_time')
      expect(last_response.body).to include('end_time')
    end
  end
end
