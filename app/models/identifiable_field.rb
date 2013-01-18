class IdentifiableField
  include Mongoid::Document
  field :field_name
  field :class_name
  field :description
  #field :field_type
  
  has_many :identifiable_entries
end
