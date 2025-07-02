module SupplyTeachers
  class BranchSearchResult
    attr_reader :id, :supplier_name, :name, :contact_name, :telephone_number, :contact_email, :slug
    attr_accessor :rate, :distance, :daily_rate, :worker_cost, :agency_fee, :error, :finders_fee

    def initialize(id:, supplier_name:, name:, contact_name:, telephone_number:, contact_email:, slug:)
      @id = id
      @supplier_name = supplier_name
      @name = name
      @contact_name = contact_name
      @telephone_number = telephone_number
      @contact_email = contact_email
      @slug = slug
    end
  end
end
