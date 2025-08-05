class LegalPanelForGovernment::RM6360::SupplierSpreadsheetCreator < SupplierSpreadsheetCreator
  def build
    super do |shortlist_sheet, audit_sheet|
      add_supplier_details(shortlist_sheet)
      add_audit_trail(audit_sheet)
    end
  end

  private

  def add_audit_trail(audit_sheet)
    lot = Lot.find(@params['lot_id'])
    audit_sheet.add_row ['Lot', "#{lot.number} - #{lot.name}"]

    add_services(audit_sheet)

    return unless lot.id.starts_with?('RM6360.4')

    add_countries(audit_sheet)
  end

  def add_supplier_details(shortlist_sheet)
    shortlist_sheet.add_row ['Supplier name', 'Phone number', 'Email']

    @supplier_frameworks.each do |supplier_framework|
      shortlist_sheet.add_row(
        [
          supplier_framework.supplier_name,
          supplier_framework.contact_detail.telephone_number,
          supplier_framework.contact_detail.email
        ]
      )
    end
  end

  def add_services(sheet)
    services = Service.where(id: @params['service_ids']).order(:id).pluck(:name)
    sheet.add_row ['Services', services.join('; ')]
  end

  def add_countries(sheet)
    countries = Jurisdiction.where(
      id: if @params['not_core_jurisdiction'] == 'no'
            LegalPanelForGovernment::RM6360::Journey::ChooseJurisdiction::CORE_JURISDICTIONS
          else
            @params['jurisdiction_ids']
          end
    ).order(:name).pluck(:name)

    sheet.add_row ['Countries', countries.join('; ')]
  end
end
