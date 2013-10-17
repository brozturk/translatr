FactoryGirl.define do
  factory :text do 
    title { Faker::Lorem.sentence }
    text {Faker::Lorem.sentence}
  end
end
