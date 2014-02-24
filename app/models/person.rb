class Person < Entity

  has_many :identifiable_entries, :dependent=>:destroy
	has_many :activities

  before_validation :set_defaults
  validates_presence_of :name

  def set_defaults
    if self.name.blank?
      self.name = identifier_value
    end
	true
  end

  def populated_identifiables
    identifiable_entries.select{|e| !e.field_value.blank?}
  end

  def identifier
    return name unless name.blank?
    unless populated_identifiables.empty?
  	  populated_identifiables.first
  	else
  	  nil
  	end
  end

  def identifier_value
    identifier.field_value unless identifier.nil?
  end

  def create_activities(links)
		activity_links = activities.collect(&:url)
		recorded_time = Time.now
		links.each do |link|
	  	if activity_links.include?(link) == false
				self.activities << Activity.create!(url: link, recorded_at: recorded_time)
	  	#else
				#log that activity has already been created
	  	end
		end
		return self.activities.where(recorded_at: recorded_time)
  end

  class << self
    def initialize_identifiables #may move to some kind of initializer
      %w{email_address webpage twitter handle}.each do |i|
        Person.create_field(i)
      end
    end
  end
end

Person.initialize_identifiables
