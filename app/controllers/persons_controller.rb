class PersonsController < ApplicationController
  
  # GET /persons
  # GET /persons.json
  def index
    @persons = Person.all

    respond_to do |format|
      #format.html # index.html.erb
	  redirect_to root_path
      format.json { render json: @persons }
    end
  end

  # GET /persons/1
  # GET /persons/1.json
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end

  # GET /persons/new
  # GET /persons/new.json
  def new
    @person = Person.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  # GET /persons/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /persons
  # POST /persons.json
  def create
    @person = Person.new
  	populate_attributes(@person, params[:person])
    
    respond_to do |format|
      if @person.save
        @person = Person.find(@person.id)
        populate_attributes(@person, params[:person])
        @person.save

        format.html { redirect_to  @person, notice: 'Person was successfully created.' }
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { render action: "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /persons/1
  # PUT /persons/1.json
  def update
    @person = Person.find(params[:id])

    populate_attributes(@person, params[:person])
    respond_to do |format|
      
      if @person.save && @person.identifiable_entries.each(&:save!)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /persons/1
  # DELETE /persons/1.json
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

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

end
