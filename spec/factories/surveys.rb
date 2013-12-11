Fabricator(:survey) do
  url { sequence(:url) { |i| "fakeurl#{i}" } }
end