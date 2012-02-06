# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email)      {|n| "user#{n}#{rand}@example.com" }
    password "Passw0rd"
    consented false

    factory :consenting_user do
      consented true

      factory :consenting_control_user do
        control_group true
      end

      factory :consenting_game_user do
        control_group false
      end
    end
  end
end
