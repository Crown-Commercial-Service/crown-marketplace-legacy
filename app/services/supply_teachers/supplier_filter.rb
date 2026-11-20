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
    query = Supplier::Framework.joins(:supplier).with_lots(@lot_id)

    if agency_name.present?
      search_term = "%#{agency_name.downcase}%"

      query = query.where(
        'lower(suppliers.name) LIKE :term OR lower(suppliers.additional_details->>\'trading_name\') LIKE :term',
        term: search_term
      )
    end

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
