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
		@persons = Person.all
		@person_results = Array.new
		
		if params[:search_result]
      debugger
			if params[:search_result][:person_id]
				person = Person.where(id: params[:search_result][:person_id]).first
				if person
					results = @search.find_term_in_results#(person.name)
					@person_results = person.create_activities(results) unless results.blank?
				end
			end
		end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @search }
    end
  end

  # GET /searchs/new
  # GET /searchs/new.json
  def new
    @search = Search.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @search }
    end
  end

  # GET /searchs/1/edit
  def edit
    @search = Search.find(params[:id])
  end

  # POST /searchs
  # POST /searchs.json
  def create
    @search = Search.new
  	populate_attributes(@search, params[:search])
    
    respond_to do |format|
      if @search.save
        @search = Search.find(@search.id)
        populate_attributes(@search, params[:search])
        @search.save

        format.html { redirect_to  @search, notice: 'Search was successfully created.' }
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

    populate_attributes(@search, params[:search])
    respond_to do |format|
      
      if @search.save && @search.identifiable_entries.each(&:save!)
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
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
        unless params[field].blank?
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
