FactoryGirl.define do
  factory :user do #define a valid user
    name     "Example User"
    email    "user@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end