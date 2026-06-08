module SupplyTeachers::RM6238::Admin::SectionsConcern
  extend ActiveSupport::Concern

  include Admin::SectionsConcern

  SECTION_TO_PARAMS = {
    basic_supplier_information: %i[name],
  }.freeze
end
