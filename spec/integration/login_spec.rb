require 'spec_helper'

describe "the signup process", :type => :request do
  let!(:user) { Factory(:user, password: 'weeewwweeee') }

  it "signs me in" do
    visit root_url

    fill_in 'user[email]', :with => user.email
    fill_in 'user[password]', :with => user.password

    click_button 'Sign in'
  end
end
