require_relative '../spec_helper.rb'

describe "home controller" do

  describe "GET index" do
    it "shows a welcome message" do
      get "/"

      expect(last_response.body).to include('Log In')
      expect(last_response.body).to include('Register')
    end
  end

  describe 'GET /register' do
    it 'displays a form for the user to enter their registration information' do
      get '/register'

      expect(last_response.body).to include('<form')
      expect(last_response.body).to include('</form>')
      expect(last_response.body).to include('first_name')
      expect(last_response.body).to include('last_name')
      expect(last_response.body).to include('password')
      expect(last_response.body).to include('email')
    end
  end

  describe 'GET /login' do
    it 'displays a form for the user to enter their log in information' do
      get '/login'

      expect(last_response.body).to include('<form')
      expect(last_response.body).to include('</form>')
      expect(last_response.body).to include('password')
      expect(last_response.body).to include('email')
    end
  end
end
