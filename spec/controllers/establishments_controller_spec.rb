require 'rails_helper'

RSpec.describe Api::V1::EstablishmentsController, type: :controller do
  let(:valid_attributes) do
    {
      name: 'Nome do Estabelecimento',
      fantasy_name: 'Nome Fantasia',
      category: 'Categoria',
      cnpj: '12345678901234',
      phone: '1234567890',
      whatsapp: '1234567890',
      email: 'email@example.com',
      owner_id: 1,
      opening_hours: '08:00',
      closing_time: '18:00',
      address: {
        street: 'Rua Exemplo',
        city: 'Cidade',
        state: 'Estado',
        zip_code: '12345-678',
        country: 'País'
      }
    }
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Establishment' do
        expect {
          post :create, params: { establishment: valid_attributes }
        }.to change(Establishment, :count).by(1)
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