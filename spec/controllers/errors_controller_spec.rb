# spec/errors_controller_spec.rb
require_relative '../spec_helper.rb'

describe "handling errors" do
  describe "general 404 error" do
    it "renders a generic 404 page" do
      get "/i/am/definitely/not/a/route"

      expect(last_response.status).to eq(404)
      expect(last_response.body).to match(/couldn't find that page/i)
    end
  end
end
