require 'faker'

FactoryGirl.define do
  factory :tenant do |f|
    f.name { Faker::HarryPotter.location }
  end
end
