require 'spec_helper'

describe PortalController do
  render_views

  let(:user) { Fabricate :user }


  describe "GET 'index'" do
    it "shows games" do
      visit root_url
      page.should have_content('Home')
    end
  end
end
