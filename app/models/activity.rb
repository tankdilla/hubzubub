class Activity
  include Mongoid::Document
  
  field :description
  field :recorded_at, type: DateTime
  field :reference_date, type: DateTime

  require 'identifiable'
  include Identifiable::InstanceMethods
  extend  Identifiable::ClassMethods
  
  has_many :identifiable_entries
  belongs_to :profile
  belongs_to :entity

  validate :entity_and_profile

  def entity_and_profile
  	!entity.blank? && !profile.blank?
  end

  class << self
    def initialize_identifiables #may move to some kind of initializer
      %w{action url}.each do |i|
        Activity.create_field(i)
      end
    end
  end
end