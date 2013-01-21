class Profile
  include Mongoid::Document
  
  field :name
  field :description
  
  has_many :persons
  has_many :businesses
  has_many :activities

  before_create :set_defaults

  def set_defaults
  	if name.blank?
  		if !persons.blank?
  			name = persons.first.identifier
  		elsif !businesses.blank?
  			name = businesses.first.name
  		end
  	end
  end
end