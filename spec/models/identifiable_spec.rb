require 'spec_helper'

describe Identifiable do
  describe "create identifiable fields" do
    before(:each) do
      class Someclass < Entity
      end
      Someclass.drop_identifiable_fields
      Someclass.create_field("email_address")
    end

    it "should not create the same field twice" do
      Someclass.identifiable_fields.size.should == 1
      Someclass.create_field("email_address")
      Someclass.identifiable_fields.size.should == 1
    end

    
    it "should create a field for storing an email address for Someclass" do
      s = Someclass.new
      s.respond_to?("email_address").should == true
      s.email_address.blank?.should be_true
    end
    
    it "should set an email address for an instance of Someclass" do
      s = Someclass.new

      s.email_address = "guy@email.com"
      s.email_address.should == "guy@email.com"
    end
    
    it "should clear identifiable fields" do
      Someclass.create_field("twitter")
      Someclass.identifiable_fields.size.should == 2
      Someclass.drop_identifiable_fields
      Someclass.identifiable_fields.size.should == 0
    end
    
  end
end