# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Faker::Name.firs_name } 
    last_name { Faker::Name.last_name } 
    email { Faker::Internet.email } 
    password '123456'
    password_confirmation '123456'
  end
end
