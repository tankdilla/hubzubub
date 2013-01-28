class IdentifiableEntry
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :field_value
  #field :priority
  #field :reference_url
  #field :image_url
  
  belongs_to :identifiable_field
  belongs_to :person
  belongs_to :business
end