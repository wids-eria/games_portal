require 'spec_helper'

describe SurveyController do
  #render_views

  let!(:user) { Fabricate :user ,consented: false}
  let!(:consented) { Fabricate :user ,consented: true}
  let!(:game) { Fabricate :game }

  before do
    login(consented)
  end

  describe "GET 'survey'" do
    it "redirects for a not consented user" do
      login(user)
      get :show, id: game.path
      response.should redirect_to(consent_form_url)
    end

    it "shows survey for a consented user" do
      get :show, id: game.path
      response.should be_success
    end
  end
end
