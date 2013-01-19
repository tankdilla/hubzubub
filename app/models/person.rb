class Person < Entity
  has_many :addresses
  
  before_save :has_one_identifiable_entry
  
  def has_one_identifiable_entry
    return true if !name.blank?
    return false if identifiable_entries.blank?
    return true unless identifiable_entries.select{|e| e.field_value.blank?}.blank?
  end
  
  class << self
    def initialize_identifiables #may move to some kind of initializer
      ["email_address", "webpage", "twitter"].each do |i|
        Person.create_field(i)
      end
    end
  end
end