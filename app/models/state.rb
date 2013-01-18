class State
  include Mongoid::Document
  field :name, type: String
  field :_id, type: String, default: ->{ name }
  
  embeds_many :counties
  has_many :address
end