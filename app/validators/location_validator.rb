class LocationValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, value)
    return if value.found?

    record.errors.add :postcode, :invalid_location
  end
end
