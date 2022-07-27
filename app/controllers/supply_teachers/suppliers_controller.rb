module SupplyTeachers
  class SuppliersController < SupplyTeachers::FrameworkController
    helper :telephone_number

    def all_suppliers
      @back_path = source_journey.previous_step_path
      all_branches = self.class.module_parent::Branch.all.order(:slug)
      @branches_count = all_branches.count
      @branches = all_branches.page params[:page]
    end
  end
end
