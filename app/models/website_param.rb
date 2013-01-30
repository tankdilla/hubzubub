class WebsiteParam
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :description
  field :field_name
  field :field_value
  
  embedded_in :website
	
	validates_presence_of :name, :field_name
  
  scope :search_params, where(field_name: /^[search_param]/)
  scope :parse_params, where(field_name: /^[parse_param]/)
end