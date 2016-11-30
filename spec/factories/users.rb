FactoryGirl.define do
  pw = RandomData.random_sentence
  # name of factory is user
  factory :user do
    name RandomData.random_name
    #each User that factory builds will have a unique email address using sequence
    sequence(:email){|n| "user#{n}@factory.com" }
    password pw
    password_confirmation pw
    role :member
  end
end
