require 'spec_helper'

describe IdentifiableField do
  describe 'property maintenance for fields' do
  	before(:all) do
      class Someclass < Entity
      end
    end
    
  	it "should create a url property for the identifiable field" do
  		Person.initialize_identifiables
  		identifiable_fields = Person.identifiables
  	end
  end
end