require 'spec_helper'

describe Activity do
  it "should have predefined identifiable fields for action and url" do
    pending
  	Activity.drop_identifiable_fields
    Activity.initialize_identifiables
    Activity.identifiable_fields.size.should == 2
  end

  it "should require an entity and a profile" do
    pending
  	p = Person.create(:name=>"User")
  	profile = Profile.new
  	profile.persons << p
  	profile.save

  	Activity.initialize_identifiables
  	a = Activity.new
  	a.save.should be_false

  	a.action = "add"
  	a.url = "www.website.com"
  	a.entity = p
  	a.save.should be_true
  end

end
