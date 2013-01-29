require 'spec_helper'

describe Website do
  
  it "should require a base url" do
	w = Website.new
	w.save.should == false
	w.base_url = "www.google.com"
	w.save.should == true
  end
  
  

end