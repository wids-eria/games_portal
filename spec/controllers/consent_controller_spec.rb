require 'spec_helper'

describe ConsentController do
  render_views

  let(:user) { Fabricate :user }
  before do
    login(user)
  end

  describe "GET 'consent_form'" do
    it "returns success" do
      get 'form'
      response.should be_success
    end
  end

  describe "PUT 'consent'" do
    it "sets user consent to true" do
      put 'consent'
      assigns(:user).consented.should be(true)
      response.should redirect_to(root_url)
    end
  end

end
