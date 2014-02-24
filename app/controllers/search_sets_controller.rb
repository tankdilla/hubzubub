class SearchSetsController < ApplicationController
  # GET /search_sets
  # GET /search_sets.json
  def index
    @search_sets = SearchSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @search_sets }
    end
  end

  # GET /search_sets/1
  # GET /search_sets/1.json
  def show
    @search_set = SearchSet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @search_set }
    end
  end

  # GET /search_sets/new
  # GET /search_sets/new.json
  def new
    @search_set = SearchSet.new
    @searches = Search.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @search_set }
    end
  end

  # GET /search_sets/1/edit
  def edit
    @search_set = SearchSet.find(params[:id])
    @searches = Search.all
  end

  # POST /search_sets
  # POST /search_sets.json
  def create
    @search_set = SearchSet.new(params[:search_set].slice(:title, :description))

    searches = params[:search_set][:searches].select(&:present?).collect { |search_id| Search.find(search_id)}
    @search_set.searches << searches

    respond_to do |format|
      if @search_set.save
        format.html { redirect_to @search_set, notice: 'Search set was successfully created.' }
        format.json { render json: @search_set, status: :created, location: @search_set }
      else
        format.html { render action: "new" }
        format.json { render json: @search_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /search_sets/1
  # PUT /search_sets/1.json
  def update
    @search_set = SearchSet.find(params[:id])

    respond_to do |format|
      if @search_set.update_attributes(params[:search_set])
        format.html { redirect_to @search_set, notice: 'Search set was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @search_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /search_sets/1
  # DELETE /search_sets/1.json
  def destroy
    @search_set = SearchSet.find(params[:id])
    @search_set.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
end
