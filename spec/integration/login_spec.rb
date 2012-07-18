require 'spec_helper'

describe "the sign up process with an email", :type => :request do
  it "sign me up" do
    visit root_url

    click_link 'Sign up'

    fill_in 'user[email]', :with => 'testuser'
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

    fill_in 'user[email]', :with => user.email
    fill_in 'user[password]', :with => user.password

    click_button 'Sign in'
    current_path.should == '/game'
  end
end

describe "the signin process with a username", :type => :request do
  let!(:user) { Factory(:consenting_game_user, password: 'weeewwweeee', email: 'test') }

  it "signs me in" do
    visit root_url
    puts user.inspect
    fill_in 'user[email]', :with => 'test'
    fill_in 'user[password]', :with => user.password

    click_button 'Sign in'
    current_path.should == '/game'
  end
  
end
