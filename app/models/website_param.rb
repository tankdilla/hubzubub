class WebsiteParam
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :field_name
  field :description
  field :field_value
  
  embedded_in :website
	
	validates_presence_of :field_name
end