# frozen_string_literal: true

FactoryBot.define do
  factory :establishment do
    name { Faker::Company.name }
    fantasy_name { Faker::Company.name }
    email { Faker::Internet.email }
    generate_valid_phone_number
    cnpj { Faker::Company.brazilian_company_number(formatted: true) }
    owner { create(:owner) }
    opening_hours { '08:00' }
    closing_time { '18:00' }
    street { Faker::Address.street_name }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip_code { Faker::Address.postcode }
    country { Faker::Address.country }
    neighborhood { Faker::Address.community }

    # Método para gerar número de telefone válido (apenas números, 10 ou 11 dígitos)
    transient do
      phone_length { [10, 11].sample } # Seleciona aleatoriamente entre 10 ou 11 dígitos
    end

    trait :generate_valid_phone_number do
      phone { Faker::Number.number(digits: [10, 11].sample).to_s }
      whatsapp { phone }
    end
  end
end
