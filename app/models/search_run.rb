class SearchRun
  include Mongoid::Document
  include Mongoid::Timestamps

  field :search_url
  field :selector
  field :term

  belongs_to :search

  embeds_many :search_run_results
end

class SearchRunResult
  include Mongoid::Document

  field :text
  field :url

  embedded_in :search_run
end