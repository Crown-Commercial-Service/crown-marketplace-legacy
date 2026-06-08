module SupplyTeachers::RM6376::Admin::SectionsConcern
  extend ActiveSupport::Concern

  include Admin::SectionsConcern

  SECTION_TO_PARAMS = {
    basic_supplier_information: %i[name trading_name additional_identifier],
    additional_supplier_information: %i[managed_service_provider_name managed_service_provider_email managed_service_provider_telephone],
  }.freeze
end
