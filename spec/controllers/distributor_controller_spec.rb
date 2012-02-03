require 'spec_helper'

describe DistributorController do
  render_views

  let(:user) { Factory :consenting_user }
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in :user, user
  end

  describe "GET 'index'" do
    it "works for a consenting user" do
      get 'index'
      response.should be_success
    end

    it "redirects to consent if not consented" do
      sign_in :user, Factory(:user)
      get 'index'
      response.should be_redirect
    end
  end
end
