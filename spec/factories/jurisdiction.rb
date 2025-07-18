FactoryBot.define do
  factory :jurisdiction, class: 'Jurisdiction' do
    initialize_with do
      country_code = Faker::Address.country_code

      jurisdiction = Jurisdiction.find_by(id: country_code)

      if jurisdiction.present?
        jurisdiction
      else
        country_name = Faker::Address.unique.country

        new(id: country_code, name: country_name, mapping_name: country_name)
      end
    end
  end
end
