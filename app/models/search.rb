require 'nokogiri'

class Search
  include Mongoid::Document
  field :url
  field :result
  field :format

  belongs_to :website

  def run_search
  	return nil if url.nil?
  	
  	case format
  	when 'json'
  		json_search
  	else
  		html_search
  	end
  end

  def html_search
  	Page.get url
  end

  def json_search
  	JSON.parse(open(url))
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