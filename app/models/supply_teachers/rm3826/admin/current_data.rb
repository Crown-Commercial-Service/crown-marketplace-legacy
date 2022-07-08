module SupplyTeachers
  module RM3826
    module Admin
      class CurrentData < SupplyTeachers::Admin::CurrentData
        self.table_name = 'supply_teachers_rm3826_admin_current_data'

        # input files specific to this framework
        has_one_attached :lot_1_and_lot_2_comparisons
        has_one_attached :neutral_vendor_contacts
      end
    end
  end
end
