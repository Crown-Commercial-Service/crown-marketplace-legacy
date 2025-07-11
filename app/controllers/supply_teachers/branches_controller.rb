module SupplyTeachers
  class BranchesController < SupplyTeachers::FrameworkController
    before_action :set_end_of_journey
    SEARCH_RADIUSES = [50, 25, 10, 5, 1].freeze

    helper :telephone_number

    def index
      @journey = SupplyTeachers::Journey.new(params[:framework], params[:slug], params)
      @back_path = @journey.previous_step_path

      if @journey.valid?
        render_branches
      else
        @form_path = @journey.form_path
        render @journey.template
      end
    end

    def show
      @back_path = :back
      @branch = Supplier::Framework::Lot::Branch.friendly.find(params[:id])
    end

    private

    # rubocop:disable Metrics/AbcSize
    def render_branches
      @location = step.location
      @radius_in_miles = step.radius
      @alternative_radiuses = SEARCH_RADIUSES - [@radius_in_miles]
      @salary = params[:annual_salary] || params[:salary]
      @fixed_term_length = step.try(:fixed_term_length)
      @branches = step.branches(salary: @salary, fixed_term_length: @fixed_term_length)

      respond_to do |format|
        format.json { render json: @branches.find { |branch| rate_params(step.class.name.include?('FixedTermResults'))[branch.id].present? } }
        format.html
        format.xlsx do
          spreadsheet = service_name::Spreadsheet.new(@branches, with_calculations: params[:calculations].present?, slug: step.slug)
          filename = "Shortlist of agencies#{' (with calculator)' if params[:calculations].present?}.xlsx"
          send_data spreadsheet.to_xlsx, filename: filename, type: :xlsx
        end
      end
    end
    # rubocop:enable Metrics/AbcSize

    def step
      @step ||= @journey.current_step
    end

    def rate_params(is_fixed_term_results)
      is_fixed_term_results ? params[:annual_salary] : params[:daily_rate]
    end

    def service_name
      self.class.module_parent
    end
  end
end
