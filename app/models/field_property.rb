class FieldProperty
	include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :_id, type: String, default: ->{ name }

  require 'identifiable'
  include Identifiable::InstanceMethods
  extend  Identifiable::ClassMethods
  
  embeds_many :identifiable_entries
  belongs_to :identifiable_field
end