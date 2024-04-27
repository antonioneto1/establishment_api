# frozen_string_literal: true

require 'rails_helper'
require_relative '../../app/services/establishment_service'

RSpec.describe EstablishmentService do
  describe '#run' do
    let(:owner) { create(:owner) }
    let(:params) do
      {
        name: 'Nome do Estabelecimento',
        fantasy_name: 'Nome Fantasia',
        category: 'pet_shop',
        cnpj: Faker::Company.brazilian_company_number,
        phone: Faker::Number.number(digits: [10, 11].sample).to_s,
        whatsapp: Faker::Number.number(digits: [10, 11].sample).to_s,
        email: 'email@example.com',
        owner_id: owner.id,
        opening_hours: '08:00',
        closing_time: '18:00',
        address: {
          street: 'Avenida Monsenhor Tabosa 176',
          city: 'Fortaleza',
          state: 'Ceará',
          zip_code: '60165-010',
          country: 'Brasil',
          neighborhood: 'Centro'
        }
      }
    end
    it 'should do created establishment' do
      establishment_service = EstablishmentService.new(params).run
      expect(establishment_service[:success]).to be_truthy
      expect(establishment_service[:establishment].name).to eq(params[:name])
      expect(establishment_service[:establishment].coordinates).not_to be_nil
    end
  end
end
