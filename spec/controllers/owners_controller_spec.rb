# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::OwnersController, type: :controller do
  render_views
  let(:owner) { create(:owner) }

  let(:valid_attributes) do
    {
      name: 'Antonio',
      phone: '85985454297',
      email: 'acntoniocneto.dev@gmail.com',
      document_number: '02539483399',
      type_document: 'cpf',
      address: {
        street: 'Av. Monsenhor Tabosa 676',
        city: 'Fortaleza',
        state: 'Ceará',
        zip_code: '60165-010',
        country: 'Brazil',
        neighborhood: 'Centro'
      },
      establishment_attributes: {
        name: 'Bixo Arretado',
        fantasy_name: 'Bixo Arretado LTDA',
        category: 'pet_shop',
        cnpj: '54.005.872/0001-71',
        phone: '85985454397',
        whatsapp: '85985454297',
        email: 'antoniocnet@gmail.com',
        opening_hours: '09:00',
        closing_time: '18:00',
        address: {
          street: 'Av. Monsenhor Tabosa 676',
          city: 'Fortaleza',
          state: 'Ceará',
          zip_code: '60165-010',
          country: 'Brazil',
          neighborhood: 'Centro'
        }
      }
    }
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'create a new Owner' do
        expect do
          post :create, params: { owner: valid_attributes }
        end.to change(Owner, :count).by(1)
      end

      it 'create a new Establishment' do
        expect do
          post :create, params: { owner: valid_attributes }
        end.to change(Establishment, :count).by(1)
      end

      it 'renders a JSON response with the new establishment' do
        post :create, params: { owner: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.body).to include(valid_attributes[:name])
        expect(response.body).to include(valid_attributes[:document_number])
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new establishment' do
        post :create, params: { owner: { document_number: nil } }
        result = JSON.parse(response.body, symbolize_names: true)
        error_message = result[:error]

        expect(error_message).to include("Document number can't be blank")
      end
    end
  end
end
