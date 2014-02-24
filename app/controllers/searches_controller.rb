class SearchesController < ApplicationController

  before_filter :find_website

  # GET /searchs
  # GET /searchs.json
  def index
    @searches = @website.searches.all

    respond_to do |format|
      format.html #index.html.erb
      format.json { render json: @searches }
    end
  end

  # GET /searchs/1
  # GET /searchs/1.json
  def show
    @search = Search.find(params[:id])
    @search_run = SearchRun.new

		# if params[:search_result]

  #     search_terms =
  #       if params[:search_result][:use_description_terms] == '1'
  #         @search.description.split(' ')
  #       else
  #         []
  #       end

  #     search_results = @search.scan(params[:search_result][:selector], search_terms)

  #     search_run = SearchRun.new(search_url: @website.search_url, selector: params[:search_result][:selector])
  #     @search.search_runs << search_run

  #     search_results.each do |result|
  #       url = result[:url]

  #       url = @website.base_url + result[:url] if result[:url].start_with?('/')

  #       search_run.search_run_results << SearchRunResult.new(text: result[:text], url: url)
  #     end
		# end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @search }
    end
  end

  # GET /searchs/new
  # GET /searchs/new.json
  def new
    @search = Search.new
		@search_types = Search.search_types

    @search.url = @website.search_url

    @site_search_params = @website.website_params.search_params
    @site_parse_params = @website.website_params.parse_params

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @search }
    end
  end

  # GET /searchs/1/edit
  def edit
    @search = Search.find(params[:id])
		@search_types = Search.search_types
    @site_search_params = @website.website_params.search_params
    @site_parse_params = @website.website_params.parse_params

    if params[:search_terms]
      @search.url = @website.search_url(params[:search_terms])
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /searchs
  # POST /searchs.json
  def create
    @search = @website.searches.new params[:search]

		@search.url = @website.search_url(params[:search_terms]) if params[:search_terms]

    @search.terms = @search.description.split(' ') if params[:use_description_terms]

    respond_to do |format|
      if @search.save

        format.html { redirect_to  website_search_url(@website, @search), notice: 'Search was successfully created.' }
        format.json { render json: @search, status: :created, location: @search }
      else
        format.html { render action: "new" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /searchs/1
  # PUT /searchs/1.json
  def update
    @search = Search.find(params[:id])
    #populate_attributes(@search, params[:search])
    @search.update_attributes(params[:search])

    if params[:search_terms]
      @search.url = @website.search_url(params[:search_terms])
    end

    respond_to do |format|

      if @search.save
        format.html { redirect_to [@website, @search], notice: 'Search was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searchs/1
  # DELETE /searchs/1.json
  def destroy
    @search = Search.find(params[:id])
    @search.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  private
  def populate_attributes(instance, params)
  	if params && params.is_a?(Hash) && !params.keys.empty?
  	  params.keys.each do |field|
        unless params[field].blank? || instance.respond_to?(field.to_s) == false
          instance.send("#{field}=", params[field])
        end
  	  end
  	end

	 instance
  end

  def find_website
    @website = Website.where(id: params[:website_id]).first
  end

end
