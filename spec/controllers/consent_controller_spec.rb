require 'spec_helper'

describe ConsentController do
  render_views

  let(:user) { Factory :user }
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in :user, user
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
