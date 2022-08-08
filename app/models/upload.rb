class Upload < ApplicationRecord
  def self.supplier_module
    module_parent::Supplier
  end

  def self.upload!(suppliers)
    error = all_or_none(supplier_module) do
      supplier_module.destroy_all

      suppliers.map do |supplier_data|
        create_supplier!(supplier_data)
      end
      create!
    end
    raise error if error
  end

  def self.all_or_none(transaction_class)
    error = nil
    transaction_class.transaction do
      yield
    rescue ActiveRecord::RecordInvalid => e
      error = e
      raise ActiveRecord::Rollback
    end
    error
  end
end
