# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::EstablishmentsController, type: :controller do
  render_views
  let(:owner) { create(:owner) }

  let(:valid_attributes) do
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

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Establishment' do
        expect do
          post :create, params: { establishment: valid_attributes }
        end.to change(Establishment, :count).by(1)
      end

      it 'renders a JSON response with the new establishment' do
        post :create, params: { establishment: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.body).to include(valid_attributes[:name])
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new establishment' do
        post :create, params: { establishment: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end
