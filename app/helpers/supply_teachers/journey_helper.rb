module SupplyTeachers::JourneyHelper
  def positions
    case params[:framework]
    when 'RM6238'
      Position.where(lot_id: 'RM6238.1', number: [1, 3, 5, 7]).order(:number)
    when 'RM6376'
      Position.where(lot_id: 'RM6376.1', number: [1, 2, 3,4, 5, 6, 7, 8]).order(:number)
    end
  end

  def offsets
    case params[:framework]
    when 'RM6238'
      [
        [0, 'daily'],
        [1, 'six_weeks_plus'],
      ]
    when 'RM6376'
      [
        [0, 'daily'],
        [1, 'six_weeks_plus'],
      ]
    end
  end
end
