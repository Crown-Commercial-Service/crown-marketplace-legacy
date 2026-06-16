module LegalServices::RM6374::Admin::SectionsConcern
  extend ActiveSupport::Concern

  include Admin::SectionsConcern

  SECTION_TO_PARAMS = {
    basic_supplier_information: %i[name duns_number sme],
    supplier_contact_information: %i[email telephone_number website],
    additional_supplier_information: %i[address description lot_1a_prospectus_link lot_1b_prospectus_link lot_1c_prospectus_link lot_2_prospectus_link lot_3_prospectus_link lot_4_prospectus_link lot_5_prospectus_link lot_6_prospectus_link]
  }.freeze
end
