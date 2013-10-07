# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :translation do
    question { Faker::Lorem.sentence } 
    answer {Faker::Lorem.sentence } 
  end
end
