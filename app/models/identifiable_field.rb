class IdentifiableField
  include Mongoid::Document
  field :field_name
  field :class_name
  field :description
  
  # has_many :field_properties
  has_many :identifiable_entries, :dependent=>:destroy
end
