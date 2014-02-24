class HomeController < ApplicationController
  def index
    @websites = Website.all
    @search_set = SearchSet.all
  end
end
