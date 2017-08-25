require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.name { Faker::GameOfThrones.character }
  end
end