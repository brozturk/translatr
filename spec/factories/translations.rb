# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :translation do
    translation_text { Faker::Lorem.sentence } 
  end
end
