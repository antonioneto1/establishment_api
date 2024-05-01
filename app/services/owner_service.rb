# frozen_string_literal: true

class OwnerService
  def initialize(params)
    @params = params
  end

  def run
    ActiveRecord::Base.transaction do
      owner = create_owner
      establishment_result = create_establishment(owner)
      if establishment_result[:success]
        { success: true, owner: owner }
      else
        owner.destroy! if owner.present?
        { success: false, error_message: "establishment_errors: #{establishment_result[:error_message]}" }
      end
    end
  rescue StandardError => e
    { success: false, error_message: e.message }
  end

  def create_owner
    owner = Owner.new(owner_params)
    raise StandardError, owner.errors.full_messages.join(', ') unless owner.valid? && owner.save

    owner
  end

  def create_establishment(owner)
    params = establishment_params.merge!(owner_id: owner.id)
    EstablishmentService.new(params).run
  end

  private

  def owner_params
    {
      name: @params[:name],
      type_document: @params[:type_document],
      document_number: @params[:document_number],
      phone: @params[:phone],
      email: @params[:email],
      street: @params.dig(:address, :street),
      city: @params.dig(:address, :city),
      state: @params.dig(:address, :state),
      zip_code: @params.dig(:address, :zip_code),
      country: @params.dig(:address, :country),
      neighborhood: @params.dig(:address, :neighborhood)
    }
  end

  def establishment_params
    {
      name: @params[:establishment_attributes][:name],
      fantasy_name: @params[:establishment_attributes][:fantasy_name],
      category: @params[:establishment_attributes][:category],
      cnpj: @params[:establishment_attributes][:cnpj],
      phone: @params[:establishment_attributes][:phone],
      whatsapp: @params[:establishment_attributes][:whatsapp],
      email: @params[:establishment_attributes][:email],
      opening_hours: @params[:establishment_attributes][:opening_hours],
      closing_time: @params[:establishment_attributes][:closing_time],
      address: {
        street: @params.dig(:establishment_attributes, :address, :street),
        city: @params.dig(:establishment_attributes, :address, :city),
        state: @params.dig(:establishment_attributes, :address, :state),
        zip_code: @params.dig(:establishment_attributes, :address, :zip_code),
        country: @params.dig(:establishment_attributes, :address, :country),
        neighborhood: @params.dig(:establishment_attributes, :address, :neighborhood)
      }
    }
  end
end
