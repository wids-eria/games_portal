module OauthLoginMockHelpers
  # for use in request specs
  def oauth_callback_for(user)
    raise 'Account not linked to oauth' if user.uid.blank?
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:ada] = {
      'provider' => 'ada',
      'uid' => user.uid,
      'info' => {
        'email' => user.email
      },
      'credentials' => {
        'token' => '123456'
      },
      'extra' => {
        'raw_info' => {
          'info' => {
            'email' => user.email,
            'player_name' => user.username
          }
        }
      }
    }
  end

  end

  RSpec.configure do |config|
  config.include OauthLoginMockHelpers, :type => :request

  config.before(:each) do
    OmniAuth.config.test_mode = false
  end
end