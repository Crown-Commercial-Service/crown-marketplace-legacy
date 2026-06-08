module LegalPanelForGovernment::RM6360::Admin::SectionsConcern
  extend ActiveSupport::Concern

  include Admin::SectionsConcern

  SECTION_TO_PARAMS = {
    basic_supplier_information: %i[name duns_number sme],
    supplier_contact_information: %i[email telephone_number website],
    additional_supplier_information: %i[address lot_1_prospectus_link lot_2_prospectus_link lot_3_prospectus_link lot_4a_prospectus_link lot_4b_prospectus_link lot_4c_prospectus_link lot_5_prospectus_link]
  }.freeze
end
