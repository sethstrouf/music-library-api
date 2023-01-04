FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email  { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :admin do
      first_name { 'Seth' }
      last_name  { 'Strouf' }
      email  { 'seth@mail.com' }
      password { ENV["ADMIN_PASSWORD"] }
      admin { true }
    end
  end

end
