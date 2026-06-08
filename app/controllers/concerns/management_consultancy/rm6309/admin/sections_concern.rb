module ManagementConsultancy::RM6309::Admin::SectionsConcern
  extend ActiveSupport::Concern

  include Admin::SectionsConcern

  SECTION_TO_PARAMS = {
    basic_supplier_information: %i[name duns_number sme],
    supplier_contact_information: %i[name email telephone_number website],
    additional_supplier_information: %i[address]
  }.freeze
end
