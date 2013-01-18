require 'spec_helper'

describe Profile do
  describe 'create a person entity profile' do
    it "should create a person with a name" do
      p = Person.new(:name=>"Joe Blow")
      p.name.should == "Joe Blow"
    end
  end
end