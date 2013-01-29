class WebsiteParamsController < ApplicationController
  before_filter :find_website
	
  # GET /websites
  # GET /websites.json
  def index
    @website_params = @website.website_params

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @website_params }
    end
  end

  # GET /websites/1
  # GET /websites/1.json
  def show
    @website_param = @website.website_params.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @website_param }
    end
  end

  # GET /websites/new
  # GET /websites/new.json
  def new
    @website_param = @website.website_params.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @website_param }
    end
  end

  # GET /websites/1/edit
  def edit
    @website_param = @website.website_params.find(params[:id])
  end

  # POST /websites
  # POST /websites.json
  def create
    @website_param = @website.website_params.new
		
		populate_attributes(@website_param, params[:website_param])
    
    respond_to do |format|
      if @website_param.save
        format.html { redirect_to website_params_path(@website), notice: 'Website params was successfully created.' }
        format.json { render json: @website_param, status: :created, location: @website_param }
      else
        format.html { render action: "new" }
        format.json { render json: @website_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /websites/1
  # PUT /websites/1.json
  def update
    @website_param = @website.website_params.find(params[:id])
		populate_attributes(@website_param, params[:website])
    respond_to do |format|
      if @website_param.save
        format.html { redirect_to website_params_path(@website), notice: 'Website params was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @website_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /websites/1
  # DELETE /websites/1.json
  def destroy
    @website_param = @website.website_params.find(params[:id])
    @website_param.destroy

    respond_to do |format|
      format.html { redirect_to website_params_path(@website) }
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
	
	def find_website
    @website = Website.where(id: params[:website_id]).first
  end

end
