class Person < Entity
  has_many :addresses
  belongs_to :profile
  
  before_save :set_defaults
  validate :has_one_identifiable_entry       
  
  def has_one_identifiable_entry
    return true if !name.blank?
    return false if identifiable_entries.blank?
    return true unless identifiable_entries.select{|e| e.field_value.blank?}.blank?
  end
  
  def set_defaults
    if self.name.blank?
	  debugger
      self.name = identifier_value
    end
	true
  end

  def populated_identifiables
    identifiable_entries.select{|e| !e.field_value.blank?}
  end

  def identifier
    return name unless name.blank?
	unless populated_identifiables.empty?
	  populated_identifiables.first
	else
	  nil
	end
  end

  def identifier_value
    identifier.field_value unless identifier.nil?
  end
  
  class << self
    def initialize_identifiables #may move to some kind of initializer
      %w{email_address webpage twitter handle}.each do |i|
        Person.create_field(i)
      end
    end
  end
end

Person.initialize_identifiables
