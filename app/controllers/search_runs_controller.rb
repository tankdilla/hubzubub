class SearchRunsController < ApplicationController
  before_filter :find_params, except: [:index, :create]

  def show
  end

  def create

    @website = Website.where(id: params[:website_id]).first
    @search = @website.searches.where(id: params[:search_id]).first

    # search_results = @search.scan

    search_run = SearchRun.new(search_url: @website.search_url, selector: @search.selector)
    @search.search_runs << search_run

    @search.scan.each do |result|

      url =
        if result[:url].start_with?('/')
          @website.base_url + result[:url]
        else
          result[:url]
        end

      search_run.search_run_results << SearchRunResult.new(text: result[:text], url: url)
    end

    respond_to do |format|
      format.html { redirect_to website_search_path(@website, @search) }
      format.json { head :no_content }
    end

  end

  def destroy
    @search_run.destroy

    respond_to do |format|
      format.html { redirect_to website_search_path(@website, @search) }
      format.json { head :no_content }
    end
  end

  private
  def find_params
    @website = Website.where(id: params[:website_id]).first
    @search = @website.searches.where(id: params[:search_id]).first
    @search_run = @search.search_runs.where(id: params[:id]).first
  end

end