class County
  include Mongoid::Document
  field :name, type: String
  field :_id, type: String, default: ->{ name }
  
  embedded_in :state
end