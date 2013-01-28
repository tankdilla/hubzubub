class Website < Entity
	field :url
	field :query_string

	field :next_page_param
	field :next_page_increment

	has_many :searches

	validates_presence_of :url
	before_create :set_defaults

	def create_search(search_term, format=nil)
		s = Search.new(website: self, url: "#{url}/#{query_string}#{search_term}")
		unless format.nil?
			s.format = format
		end
		
		s.result = s.run_search
		s
	end

	def store_search(search_term)
		search = create_search(search_term)
		searches << search
	end

	def set_defaults
		unless url.starts_with?('http://') or url.starts_with?('https://')
			self.url = 'http://'+ self.url
		end
	end
end