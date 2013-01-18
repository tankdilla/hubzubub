class Entity
  include Mongoid::Document
  field :name, type: String
  field :_id, type: String, default: ->{ name }
  
  require 'identifiable'
  include Identifiable::InstanceMethods
  extend Identifiable::ClassMethods
  
  embeds_many :identifiable_entries
end