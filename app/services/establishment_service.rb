# frozen_string_literal: true

class EstablishmentService
  def initialize(params)
    @params = params
  end

  def run
    create_establishment
  end

  def create_establishment
    establishment = Establishment.new(establishment_params)
    establishment.coordinates = cached_coordinates(establishment)
    if establishment.save
      { success: true, establishment: establishment }
    else
      { success: false, error_message: establishment.errors.full_messages.join(', ') }
    end
  end

  private

  def cached_coordinates(establishment)
    cached_result = Rails.cache.fetch(cache_key(establishment), expires_in: 1.day) do
      find_coordinates(establishment)
    end
    { latitude: cached_result[:latitude], longitude: cached_result[:longitude] }
  end

  def find_coordinates(establishment)
    full_address = establishment_full_address(establishment)
    geocoded_data = Geocoder.search(full_address).first
    if geocoded_data.present?
      { latitude: geocoded_data.latitude, longitude: geocoded_data.longitude }
    else
      { latitude: nil, longitude: nil }
    end
  end

  def cache_key(establishment)
    "establishment_coordinates_#{establishment.id}"
  end

  def establishment_params
    {
      name: @params[:name],
      fantasy_name: @params[:fantasy_name],
      category: @params[:category],
      cnpj: @params[:cnpj],
      phone: @params[:phone],
      whatsapp: @params[:whatsapp],
      email: @params[:email],
      owner_id: @params[:owner_id],
      opening_hours: @params[:opening_hours],
      closing_time: @params[:closing_time],
      street: @params.dig(:address, :street),
      city: @params.dig(:address, :city),
      state: @params.dig(:address, :state),
      zip_code: @params.dig(:address, :zip_code),
      country: @params.dig(:address, :country),
      neighborhood: @params.dig(:address, :neighborhood)
    }
  end

  def establishment_full_address(establishment)
    [
      establishment.street,
      establishment.neighborhood,
      establishment.city,
      establishment.state,
      establishment.zip_code,
      establishment.country
    ].compact.join(', ')
  end
end
