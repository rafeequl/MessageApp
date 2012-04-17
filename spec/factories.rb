FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "oke#{n}@mail.com" }
    password "foobar"
  end
  
end