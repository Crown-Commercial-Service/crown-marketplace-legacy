module SupplyTeachers
  module RM3826
    class DownloadsController < SupplyTeachers::Admin::FrameworkController
      def index
        respond_to do |format|
          format.xlsx do
            spreadsheet = SupplyTeachers::RM3826::AuditSpreadsheet.new
            send_data spreadsheet.to_xlsx, filename: 'supply_teachers.xlsx', type: :xlsx
          end
        end
      end
    end
  end
end
