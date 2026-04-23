class SupplyTeachers::SupplierFilter
  include ActiveModel::Validations

  DEFAULT_SEARCH_RANGE_IN_MILES = 25

  attr_reader :agency_name, :agency_postcode

  validate :location_is_found

  def initialize(lot_id:, agency_name: nil, agency_postcode: nil)
    @lot_id = lot_id
    @agency_name = agency_name
    @agency_postcode = agency_postcode
    @location = Location.new(agency_postcode)
    @radius = DEFAULT_SEARCH_RANGE_IN_MILES
  end

  def filter_suppliers_query
    query = Supplier::Framework.with_lots(@lot_id)
                               .where(['lower(name) LIKE ?', "%#{@agency_name&.downcase}%"])

    if agency_postcode.present? && valid?
      query = query.where(id: Supplier::Framework::Lot::Branch.search(@location.point, lot_id: @lot_id, radius: @radius)
                              .unscope(:includes)
                              .reorder(nil)
                              .select('supplier_framework_lot.supplier_framework_id')
                              .distinct)
    end

    query
  end

  private

  def location_is_found
    return if @agency_postcode.blank? || @location.found?

    errors.add :agency_postcode, :invalid_location
  end
end
