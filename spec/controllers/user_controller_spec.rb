require_relative '../spec_helper.rb'

describe 'user controller' do

    describe 'get /users' do
        it "displays the user\'s account info" do
        user = User.create(email: 'someone@mail.com', first_name: 'Someone', last_name: 'Smith', password: '123')

        get "/users/#{user.id}"

        expect(last_response.body).to include('someone@mail.com')
        expect(last_response.body).to include('Someone')
        expect(last_response.body).to include('Smith')
        expect(last_response.body).to include('Your Account')
      end
    end
  end
