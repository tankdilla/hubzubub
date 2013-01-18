class Relationship
  include Mongoid::Document
  field :name
  field :object_type_1
  field :object_value_1
  field :object_type_2
  field :object_value_2
  
end