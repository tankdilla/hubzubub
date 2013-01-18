class Address
  include Mongoid::Document
  field :line
  field :line_2
  
  belongs_to :city
  belongs_to :state
  belongs_to :zip
end