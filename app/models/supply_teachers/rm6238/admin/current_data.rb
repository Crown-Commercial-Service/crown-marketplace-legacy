module SupplyTeachers
  module RM6238
    module Admin
      class CurrentData < SupplyTeachers::Admin::CurrentData
        self.table_name = 'supply_teachers_rm6238_admin_current_data'

        # input files specific to this framework
        has_one_attached :education_technology_platform_contacts
      end
    end
  end
end
