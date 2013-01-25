class Entity
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  #field :_id, type: String, default: ->{ name }
  
  require 'identifiable'
  include Identifiable::InstanceMethods
  extend Identifiable::ClassMethods
  
  has_many :activities
  embeds_many :identifiable_entries
end