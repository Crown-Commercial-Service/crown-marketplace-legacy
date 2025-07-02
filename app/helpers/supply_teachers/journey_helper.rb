module SupplyTeachers::JourneyHelper
  def positions
    case params[:framework]
    when 'RM6238'
      Position.where(id: 41..44).order(:id)
    end
  end

  def offsets
    case params[:framework]
    when 'RM6238'
      [
        [0, 'daily'],
        [5, 'six_weeks_plus'],
      ]
    end
  end
end
