require 'faker'

FactoryGirl.define do
  factory :question do |f|
    f.title { Faker::Lorem.sentence }
    association :asker, factory: :user
  end
end