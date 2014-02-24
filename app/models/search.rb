require 'nokogiri'

class Search
  include Mongoid::Document
  field :url
  field :description
	field :search_type
  field :format
  field :selector
  field :terms, type: Array

  belongs_to :website
  has_and_belongs_to_many :search_sets

  has_many :search_runs

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

  def long_description
    "#{website.site_description} - #{self.description}"
  end

	def scan(terms=[])

		results_array = Array.new

		doc = Nokogiri::HTML(run_search)

    doc.css(self.selector).each do |node|
      # binding.pry

      if self.terms.present?
        self.terms.split(' ').each do |term|
          if node.text.scan(term).present?
            results_array << {text: node.text, url: node['href']}
            break
          end
        end
      else
        results_array << {text: node.text, url: node['href']}
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
