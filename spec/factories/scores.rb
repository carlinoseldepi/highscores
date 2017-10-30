FactoryGirl.define do
    factory :score do
      player_email { Faker::Internet.email }
      score { Faker::Number.number(4) }
    end
end