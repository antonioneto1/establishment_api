class EstablishmentService
  def initialize(params)
    @params = params
  end

  def run
    create_establishments
  rescue StandardError => e
    { success: false, error_message: e.message }
  end

  private

  def create_establishments
    establishment = Establishment.new(params)
    establishment.coordinates = find_coordinates(establishment)
    establishment.save
  end

  def find_coordinates(establishment)
    Geocoder.search(establishment.address)[0]
  end

end