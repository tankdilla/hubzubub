require 'spec_helper'

describe Activity do
  it "should have predefined identifiable fields for action and url" do
    pending
  	Activity.drop_identifiable_fields
    Activity.initialize_identifiables
    Activity.identifiable_fields.size.should == 2
  end

end
