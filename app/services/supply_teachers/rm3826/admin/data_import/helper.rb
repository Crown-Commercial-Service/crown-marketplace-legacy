module SupplyTeachers::RM3826::Admin::DataImport::Helper
  # rubocop:disable Metrics/CyclomaticComplexity
  def symbolize_job_types(row, spreadsheet)
    job_type = case row[:job_type]
               when /Qualified.*Non-Special/m
                 :qt
               when /Qualified.*Special/m
                 :qt_sen
               when /Unqualified.*Non-Special/m
                 :uqt
               when /Unqualified.*Special/m
                 :uqt_sen
               when /Support.*Non-Special/m
                 :support
               when /Support.*Special/m
                 :support_sen
               when /Senior/m
                 :senior
               when /Clerical/m
                 :admin
               when /Nominated/m
                 :nominated
               when /Fixed Term/m
                 :fixed_term
               else
                 @errors << "#{row[:supplier_name]}: Unknown job type in '#{spreadsheet}.xlsx': #{row[:job_type].inspect}" if supplier_accredited?(row[:supplier_name])
                 :unknown
               end
    row.merge(job_type: job_type)
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def accredited_suppliers_sheets
    ['Lot 1 - Preferred Supplier List', 'Lot 2 - Master Vendor MSP', 'Lot 3 - Neutral Vendor MSP']
  end
end
