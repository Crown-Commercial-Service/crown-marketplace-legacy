class Upload < ApplicationRecord
  belongs_to :framework, inverse_of: :uploads

  def self.upload!(framework, suppliers)
    error = all_or_none(framework) do
      supplier_frameworks = Supplier::Framework.where(framework:)
      supplier_ids = supplier_frameworks.pluck(:supplier_id)

      supplier_frameworks.find_each(&:destroy)
      Supplier.where(id: supplier_ids).find_each(&:destroy)

      suppliers.each do |supplier_data|
        supplier = Supplier.create!(supplier_data.except(:supplier_frameworks))

        add_supplier_framework!(supplier, supplier_data)
      end
      create!(framework_id: framework)
    end
    raise error if error
  end

  def self.smart_upload!(framework, suppliers)
    error = all_or_none(framework) do
      Supplier::Framework.where(framework:).destroy_all

      suppliers.each do |supplier_data|
        supplier = if supplier_data[:duns_number]
                     Supplier.find_by(duns_number: supplier_data[:duns_number])
                   elsif supplier_data[:id]
                     Supplier.find_by(id: supplier_data[:id])
                   end

        if supplier.present?
          supplier.update!(supplier_data.except(:id, :supplier_frameworks))
        else
          supplier = Supplier.create!(supplier_data.except(:supplier_frameworks))
        end

        add_supplier_framework!(supplier, supplier_data)
      end
    end
    raise error if error
  end

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def self.add_supplier_framework!(supplier, supplier_data)
    supplier_data[:supplier_frameworks].each do |supplier_framework_data|
      supplier_framework = supplier.supplier_frameworks.create!(supplier_framework_data.slice(:framework_id, :enabled))

      Supplier::Framework::ContactDetail.create!(supplier_framework:, **supplier_framework_data[:supplier_framework_contact_detail]) if supplier_framework_data[:supplier_framework_contact_detail]
      Supplier::Framework::Address.create!(supplier_framework:, **supplier_framework_data[:supplier_framework_address]) if supplier_framework_data[:supplier_framework_address]

      supplier_framework_data[:supplier_framework_lots].each do |supplier_framework_lot_data|
        supplier_framework_lot = supplier_framework.lots.create!(supplier_framework_lot_data.slice(:lot_id, :enabled))

        supplier_framework_lot_data[:supplier_framework_lot_services].each do |supplier_framework_lot_service_data|
          supplier_framework_lot.services.create!(supplier_framework_lot_service_data)
        end

        supplier_framework_lot_data[:supplier_framework_lot_jurisdictions].each do |supplier_framework_lot_jurisdiction_data|
          supplier_framework_lot.jurisdictions.create!(supplier_framework_lot_jurisdiction_data)
        end

        supplier_framework_lot_data[:supplier_framework_lot_rates].each do |supplier_framework_lot_rate_data|
          supplier_framework_lot.rates.create!(supplier_framework_lot_rate_data)
        end

        supplier_framework_lot_data[:supplier_framework_lot_branches].each do |supplier_framework_lot_branches_data|
          supplier_framework_lot_branches_data[:location] = Geocoding.point(
            latitude: supplier_framework_lot_branches_data[:lat],
            longitude: supplier_framework_lot_branches_data[:lon]
          )

          supplier_framework_lot.branches.create!(supplier_framework_lot_branches_data.except(:lat, :lon))
        end
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def self.all_or_none(framework)
    error = nil

    lock_available = DistributedLocks.distributed_lock(framework[2..].to_i) do
      Supplier.transaction do
        yield
      rescue ActiveRecord::RecordInvalid => e
        error = e
        raise ActiveRecord::Rollback
      end
    end

    error = 'Upload already in progress, cannot do multiple uploads at the same time' unless lock_available

    error
  end
end
