# frozen_string_literal: true

FactoryBot.define do
  factory :owner do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    document_number { Faker::Number.number(digits: 11) }
    type_document { :cpf }
    street { Faker::Address.street_name }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip_code { Faker::Address.postcode }
    country { Faker::Address.country }
    neighborhood { Faker::Address.community }
    generate_valid_phone_number

    trait :generate_valid_phone_number do
      phone { Faker::Number.number(digits: [10, 11].sample).to_s }
    end
  end
end
