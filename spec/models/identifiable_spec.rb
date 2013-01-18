require 'spec_helper'

describe Identifiable do
  describe "create identifiable fields" do
    before(:all) do
      class Someclass < Entity
      end
    end
    
    it "should create a field for storing an email address for Someclass" do
      Someclass.create_field("email_address")
      s = Someclass.new
      s.respond_to?("email_address").should == true
      s.email_address.blank?.should be_true
    end
    
    it "should set an email address for an instance of Someclass" do
      Someclass.create_field("email_address")
      s = Someclass.new
      s.email_address = "guy@email.com"
      s.email_address.should == "guy@email.com"
    end
    
  end
end