class WebsitesController < ApplicationController
  
  # GET /websites
  # GET /websites.json
  def index
    @websites = Website.all

    respond_to do |format|
      #format.html # index.html.erb
	  redirect_to root_path
      format.json { render json: @websites }
    end
  end

  # GET /websites/1
  # GET /websites/1.json
  def show
    @website = Website.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @website }
    end
  end

  # GET /websites/new
  # GET /websites/new.json
  def new
    @website = Website.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @website }
    end
  end

  # GET /websites/1/edit
  def edit
    @website = Website.find(params[:id])
  end

  # POST /websites
  # POST /websites.json
  def create
    @website = Website.new
		populate_attributes(@website, params[:website])
    
    respond_to do |format|
      if @website.save
        format.html { redirect_to  @website, notice: 'Website was successfully created.' }
        format.json { render json: @website, status: :created, location: @website }
      else
        format.html { render action: "new" }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end
	
	def multi_create
		if params[:add_websites]
			website_urls = params[:add_websites]
		end
		
		successful_creates = Array.new
		fails = Array.new
		website_urls.each do |u|
			w = Website.new(base_url: u)
			if w.save
				successful_creates << w.base_url
			else
				fails << w.base_url
			end
		end
		
		respond_to do |format|
			format.html { redirect_to root_path, notice: "Websites successfully created: #{successful_creates.join(",")}, fails: #{fails.join(",")}" }
			format.json { render json: @website, status: :created, location: @website }
    end
	end

  # PUT /websites/1
  # PUT /websites/1.json
  def update
    @website = Website.find(params[:id])
	populate_attributes(@website, params[:website])
    respond_to do |format|
      if @website.save
        format.html { redirect_to @website, notice: 'Website was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /websites/1
  # DELETE /websites/1.json
  def destroy
    @website = Website.find(params[:id])
    @website.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end
  
  private
  def populate_attributes(instance, params)
	if params && params.is_a?(Hash) && !params.keys.empty?
	  params.keys.each do |field|
	    instance.send("#{field}=", params[field])
	  end
	end
	
	instance
  end

end
