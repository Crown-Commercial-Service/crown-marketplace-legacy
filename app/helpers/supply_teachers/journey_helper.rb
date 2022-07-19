module SupplyTeachers::JourneyHelper
  def job_type_class
    case params[:framework]
    when 'RM3826'
      SupplyTeachers::RM3826::JobType
    when 'RM6238'
      SupplyTeachers::RM6238::JobType
    end
  end

  def term_type_class
    case params[:framework]
    when 'RM3826'
      SupplyTeachers::RM3826::Term
    when 'RM6238'
      SupplyTeachers::RM6238::Term
    end
  end
end
