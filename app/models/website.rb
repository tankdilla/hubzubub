class Website < Entity
	field :base_url
	field :query_string

	field :next_page_param
	field :next_page_increment

	has_many :searches

	validates_presence_of :base_url #todo: validate format of base_url
	before_create :set_defaults
	
	embeds_many :website_params

	def create_search(search_term, format=nil)
		s = Search.new(website: self, url: search_url(search_term))
		unless format.nil?
			s.format = format
		end
		
		#s.result = s.run_search
		s
	end

	def search_url(search_terms)
		if !website_params.blank? && website_params.collect(&:field_name).include?('search_url_format')
			#todo: user-specified params will allow custom search. still to be determined how best to do this
		else
			#this is google's format, each site will have its own
			"#{base_url}/#{query_string}#{search_terms.split.join("+")}"
		end
	end

	def store_search(search_term)
		search = create_search(search_term)
		searches << search
	end

	def set_defaults
		unless base_url.starts_with?('http://') or base_url.starts_with?('https://')
			self.base_url = 'http://'+ self.base_url
		end
	end
end
