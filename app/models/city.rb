class City
  include Mongoid::Document
  field :name, type: String
  field :_id, type: String, default: ->{ name }
  
  embeds_many :neighborhoods
  
  has_many :address
end