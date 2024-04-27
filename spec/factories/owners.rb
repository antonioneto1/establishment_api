# frozen_string_literal: true

FactoryBot.define do
  factory :owner do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    document_number { Faker::Number.number(digits: 11) }
    type_document { :cpf }
    # address {
    #   {
    #     street: Faker::Address.street_name,
    #     city: Faker::Address.city,
    #     state: Faker::Address.state,
    #     zip_code: Faker::Address.zip_code,
    #     country: Faker::Address.country
    #   }
    # }
  end
end
