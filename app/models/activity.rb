class Activity
  include Mongoid::Document
  
  field :description
  field :recorded_at, type: DateTime
  field :reference_date, type: DateTime
  
  has_many :identifiable_entries
  belongs_to :profile
end