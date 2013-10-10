FactoryGirl.define do 
  factory :team do
    name { Faker::Lorem.sentence }
  end
end
