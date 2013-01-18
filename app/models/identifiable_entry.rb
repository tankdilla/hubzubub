class IdentifiableEntry
  include Mongoid::Document
  
  field :field_value
  #field :priority
  #field :reference_url
  #field :image_url
  
  belongs_to :identifiable_field
end