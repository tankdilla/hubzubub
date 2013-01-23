class Person < Entity
  has_many :addresses
  belongs_to :profile
  
  before_save :has_one_identifiable_entry, :set_defaults
  
  def has_one_identifiable_entry
    return true if !name.blank?
    return false if identifiable_entries.blank?
    return true unless identifiable_entries.select{|e| e.field_value.blank?}.blank?
  end
  
  def set_defaults
    if name.blank?
      name = identifier
    end
  end

  def populated_identifiables
    identifiable_entries.select{|e| !e.field_value.blank?}
  end

  def identifier
    return name unless name.blank?
    populated_identifiables.first.field_value
  end

  def identifier_value
    identifier.field_value
  end
  
  class << self
    def initialize_identifiables #may move to some kind of initializer
      %w{email_address webpage twitter}.each do |i|
        Person.create_field(i)
      end
    end
  end
end