require 'spec_helper'

describe Person do
  describe "create identifiable fields" do
    before(:each) do
      Person.drop_identifiable_fields
    end
    
    it "should create a field for storing an email address for a Person" do
      p = Person.new
      p.respond_to?("email_address").should == false
      Person.create_field("email_address")
      
      p = Person.new
      p.respond_to?("email_address").should == true
      p.email_address.blank?.should be_true
    end
    
    it "should have predefined identifiable fields for email, twitter, and webpage" do
      Person.initialize_identifiables
      Person.identifiable_fields.size.should == 4
    end
    
    it "should require a name or identifiable field before saving" do
      Person.initialize_identifiables
      p = Person.new
      p.save.should == false
      
      ["name", Person.identifiable_fields].flatten.each do |field|
        p = Person.new
        p.send(field+"=", "some value")
        p.save.should == true
      end
    end

    it "should populate the name field if an identifiable field is populated" do
      Person.initialize_identifiables
      p = Person.new
	  p.handle = "joeblo"
      p.populated_identifiables.blank?.should be_false
      p.populated_identifiables.size.should == 1
      p.identifier_value.should == "joeblo"

    end
    
  end
end
