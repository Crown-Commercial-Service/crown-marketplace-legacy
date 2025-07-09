module ManagementConsultancy::RM6309::SuppliersHelper
  include ManagementConsultancy::JourneyHelper

  def rate_position_types
    @rate_position_types ||= if @lot.id == 'RM6309.10'
                               {
                                 names: ['Complex', 'Non-Complex'],
                                 offset: 31
                               }
                             else
                               {
                                 names: ['Advice', 'Delivery',],
                                 offset: 19
                               }
                             end
  end
end
