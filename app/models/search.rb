require 'nokogiri'

class Search
  include Mongoid::Document
  field :url
	field :search_type
  field :format

  belongs_to :website

  def run_search
  	return nil if url.nil?
  	
  	case format
  	when 'json'
  		json_search
  	else
  		html_search.body #figure this out...
  	end
  end

  def html_search
  	Page.get url
  end

  def json_search
  	JSON.parse(open(url))
  end

	def find_term_in_results#(search_term)
		
		results_array = Array.new
		#return nil if result.blank?
		doc = Nokogiri::HTML(run_search) #(result)
		if true #website.base_url.ends_with?('www.google.com')
		  doc.xpath('//cite').each do |node|
		    results_array << node.text
		  end
		end
		results_array
	end
	
	def self.search_types
		['search_site', 'parse_page']
	end
	
end

class HtmlParserIncluded < HTTParty::Parser
  SupportedFormats.merge!('text/html' => :html)

  def html
    Nokogiri::HTML(body)
  end
end

class Page
  include HTTParty
  parser HtmlParserIncluded
end

class JSONPage
  include HTTParty
  parser :json
end
