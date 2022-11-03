module SupplyTeachers::JourneyHelper
  def job_type_class
    case params[:framework]
    when 'RM6238'
      SupplyTeachers::RM6238::JobType
    end
  end

  def term_type_class
    case params[:framework]
    when 'RM6238'
      SupplyTeachers::RM6238::Term
    end
  end
end
