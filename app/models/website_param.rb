class WebsiteParam
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :field_name
  field :description
  field :field_value
  
  embedded_in :website
end