module SupplyTeachers::RM6238::Admin::DataImport::Helper
  # rubocop:disable Metrics/CyclomaticComplexity
  def symbolize_job_types(row, _spreadsheet)
    job_type = case row[:job_type]
               when /Teacher/m
                 :teacher
               when /Educational/m
                 :support
               when /Senior/m
                 :senior
               when /Other/m
                 :other
               when /Over/m
                 :over_12_week
               when /Nominated/m
                 :nominated
               when /Fixed Term/m
                 :fixed_term
               when /Agency.*Daily supply worker/m
                 :agency_management_daily
               when /Agency.*Long term assignment/m
                 :agency_management_long_term
               else
                 @errors << "#{row[:supplier_name]}: Unknown job type in '#{spreadsheet}.xlsx': #{row[:job_type].inspect}" if supplier_accredited?(row[:supplier_name])
                 :unknown
               end
    row.merge(job_type:)
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def accredited_suppliers_sheets
    ['Lot 1 - Preferred Supplier List', 'Lot 2 - Master Vendor', 'Lot 4 - Education technology']
  end
end
