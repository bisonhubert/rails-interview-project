require 'faker'

FactoryGirl.define do
  factory :answer do |f|
    f.body { Faker::Lorem.sentence }
    association :question
    association :answerer, factory: :user
  end
end
