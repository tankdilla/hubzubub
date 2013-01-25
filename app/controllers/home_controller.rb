class HomeController < ApplicationController
  def index
    @users = User.all

    if params[:person]
    	@person = Person.search(params[:person])
    elsif params[:business]
    	@business = Business.search(params[:business])
    end

    if params[:person] && @person.nil?
    	flash[:notice] = "Person not found"
    elsif params[:business] && @business.nil?
    	flash[:notice] = "Business not found."
    end
	
	@persons = Person.all
	@businesses = Business.all
  end
end
