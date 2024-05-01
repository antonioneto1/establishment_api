# frozen_string_literal: true

require 'rails_helper'
require_relative '../../app/services/owner_service'

RSpec.describe OwnerService do
  describe '#run' do
    let(:params) do
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

    it 'should do created owner' do
      owner_service = OwnerService.new(params).run
      expect(owner_service[:success]).to be_truthy
      expect(owner_service[:owner].name).to eq(params[:name])
    end

    context 'should not created establishment' do
      let(:params) do
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
              state: nil,
              zip_code: '60165-010',
              country: 'Brazil',
              neighborhood: nil
            }
          }
        }
      end

      it ' should not create an owner if you do not create the establishment' do
        owner_service = OwnerService.new(params).run
        expect(owner_service[:success]).to be_falsey
        expect(owner_service[:error_message]).to include('State can\'t be blank, Neighborhood can\'t be blank')
        expect(Establishment.count).to eq(0)
        expect(Owner.count).to eq(0)
      end
    end
  end
end
