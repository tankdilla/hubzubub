class Activity
  include Mongoid::Document
  
  field :description
  field :recorded_at, type: DateTime
  field :reference_date, type: DateTime
  field :url

  require 'identifiable'
  include Identifiable::InstanceMethods
  extend  Identifiable::ClassMethods
  
  has_many :identifiable_entries
  belongs_to :website
  belongs_to :profile
  belongs_to :entity

  validate :entity_and_profile

  def entity_and_profile
  	!entity.blank? && !profile.blank?
  end

  
end