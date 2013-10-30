require 'spec_helper'

describe "the sign up process with an email", :type => :request do
  it "sign me up" do
    visit root_url

    click_link 'Sign up'

    fill_in 'user[player_name]', :with => 'testuser'
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'

    click_button 'Sign up'
    current_path.should == '/consent/form'
  end
end

describe "the signin process with an email", :type => :request do
  let!(:user) { Factory(:consenting_game_user, password: 'weeewwweeee') }

  it "signs me in" do
    visit root_url

    fill_in 'user[login]', :with => user.email
    fill_in 'user[password]', :with => user.password

    click_button 'Sign in'
    current_path.should == '/game'
  end
end

describe "the signin process with a username", :type => :request do
  let!(:user) { Factory(:consenting_game_user, password: 'weeewwweeee', player_name: 'test') }

  it "signs me in" do
    visit root_url
    fill_in 'user[login]', :with => 'test'
    fill_in 'user[password]', :with => user.password

    click_button 'Sign in'
    current_path.should == '/game'
  end
  
end
