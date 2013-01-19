class Profile
  include Mongoid::Document
  
  field :name
  field :description
  
  has_many :people
  has_many :businesses
  has_many :activities
end