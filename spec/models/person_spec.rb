require 'spec_helper'

describe Person do
  describe "create identifiable fields" do
    it "should create a field for storing an email address for a Person" do
      p = Person.new
      p.respond_to?("email_address").should == false
      Person.create_field("email_address")
      
      p = Person.new
      p.respond_to?("email_address").should == true
      p.email_address.blank?.should be_true
    end
  end
end