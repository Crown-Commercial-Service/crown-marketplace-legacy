module SupplyTeachers
  class CalculationsController < SupplyTeachers::FrameworkController
    before_action :set_end_of_journey, only: %i[temp_to_perm_fee fta_to_perm_fee]

    def temp_to_perm_fee
      journey = SupplyTeachers::Journey.new(params[:framework], params[:slug], params)
      previous_step = journey.previous_step
      @back_path = journey.previous_step_path

      @calculator = calculator(previous_step)
    end

    def fta_to_perm_fee
      journey = SupplyTeachers::Journey.new(params[:framework], params[:slug], params)
      @previous_step = journey.previous_step
      @back_path = journey.previous_step_path

      @calculator = FTAToPermCalculator::Calculator.new(
        fixed_term_contract_fee: @previous_step.try(:fixed_term_fee).try(:to_f),
        current_contract_length: @previous_step.try(:current_contract_length).try(:to_f),
      )
    end
  end
end
