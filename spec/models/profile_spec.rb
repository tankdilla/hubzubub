require 'spec_helper'

describe Profile do
  describe 'create a person entity profile' do
    it "should create a person with a name" do
      Person.initialize_identifiables
      p = Person.new(:name=>"Joe Blow")
      p.email_address = "joeblow@email.com"
      p.twitter = "@joeblow"
      p.save.should == true
      
      prof = Profile.new
      prof.persons << p
      prof.save.should == true
    end

    
  end
end