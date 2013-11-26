Fabricator(:user) do
  player_name { sequence(:player_name) { |i| "username#{i}" } }
  token { "Foo"}
  auth_token { "Bar"}
  ada_id { Fabricate.sequence }
  consented false
end
