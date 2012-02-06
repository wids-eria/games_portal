require 'spec_helper'

describe DistributorController do
  render_views

  let(:user) { Factory :consenting_control_user }
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in :user, user
  end

  describe "GET 'index'" do
    it "works for a consenting control user" do
      get 'index'
      response.should be_success
    end

    it "works for a consenting game user" do
      user = Factory :consenting_game_user
      sign_in :user, user
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
