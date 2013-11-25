require 'spec_helper.rb'

describe 'Tests Site Flow' do
  let!(:user) { Fabricate :user, consented: false}
  let!(:game) { Fabricate :game }

  it 'unlogged users have to Sign in to play game' do
    visit root_url
    click_on("Resources")
    click_on("Play")
    page.should have_content('Guest')
  end

  it 'should login/consent and access game' do
    visit root_url
    click_on("Resources")
    click_on("Play")
    click_on("Guest")
    click_on("Accept")

    find("div#unityPlayer")
  end
end