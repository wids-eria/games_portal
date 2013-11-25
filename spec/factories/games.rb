Fabricator(:game) do
  name { sequence(:name) { |i| "game#{i}" } }
  path { sequence(:path) { |i| "game#{i}" } }
  description { sequence(:description) { |i| "description#{i}" } }
  image Rack::Test::UploadedFile.new(Rails.root + 'spec/support/files/test.png', "image/png")
  file Rack::Test::UploadedFile.new(Rails.root + 'spec/support/files/test.unity3d', "application/vnd.unity")
end
