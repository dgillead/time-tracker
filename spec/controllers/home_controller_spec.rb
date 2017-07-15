require_relative '../spec_helper.rb'

describe "home controller" do

  describe "GET index" do
    it "shows a welcome message" do
      get "/"

      expect(last_response.body).to include("Welcome!")
    end
  end
end
