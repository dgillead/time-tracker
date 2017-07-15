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

  describe 'POST /login' do
    it "persists the user session" do
      user = User.create!(first_name: "Dan", email: "test@codeplatoon.com", password: "abc1234", last_name: 'Smith')
      params = { email: user.email, password: user.password }

      post "/login", params
      follow_redirect!

      expect(last_response.body).to include('Your Created Work Sessions')
    end
  end

  describe 'POST /register' do
    let (:params) do
      { email: 'someone@mail.com', first_name: 'Someone', last_name: 'Smith', password: '123' }
    end

    it "allows the user to register and saves that user\'s information" do
      expect{ post '/register', params }.to change{ User.count }.by(1)
    end

    it 'redirects the user to view all of their work sessions if the account was created' do
      post '/register', params
      follow_redirect!

      expect(last_response.body).to include('Your Created Work Sessions')
    end
  end

  describe 'GET /user/:id/sessions' do
    let (:user) do
      User.create(email: 'someone@mail.com', first_name: 'Someone', last_name: 'Smith', password: '123')
    end

    it "displays all of the current user\'s sessions" do
      get "user/#{user.id}/sessions", user

      expect(last_response.body).to include('Your Created Work Sessions')
    end
  end

  describe 'GET /logout' do
    let (:user) do
      User.create(email: 'someone@mail.com', first_name: 'Someone', last_name: 'Smith', password: '123')
    end

    it 'logs the user out and redirects to log in page' do
      sign_in(user)

      get '/logout'
      follow_redirect!

      expect(last_response.body).to include('Log In to your Account')
    end
  end
end
