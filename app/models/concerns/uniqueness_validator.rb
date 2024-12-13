class UniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.class.exists?(value)
      record.errors.add(attribute, "has already been taken")
    end
  end
end
