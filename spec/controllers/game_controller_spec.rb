require 'spec_helper'

describe GameController do
  render_views

  let(:user) { Factory :consenting_game_user }
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in :user, user
  end

  describe "GET 'player'" do
    it "works for a consenting game user" do
      get :player
      response.should be_success
    end

    it "redirects for a consenting control user" do
      user = Factory :consenting_control_user
      sign_in :user, user
      get :player
      response.should be_redirect
    end
  end
end
