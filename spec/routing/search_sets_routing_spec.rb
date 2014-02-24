require "spec_helper"

describe SearchSetsController do
  describe "routing" do

    it "routes to #index" do
      get("/search_sets").should route_to("search_sets#index")
    end

    it "routes to #new" do
      get("/search_sets/new").should route_to("search_sets#new")
    end

    it "routes to #show" do
      get("/search_sets/1").should route_to("search_sets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/search_sets/1/edit").should route_to("search_sets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/search_sets").should route_to("search_sets#create")
    end

    it "routes to #update" do
      put("/search_sets/1").should route_to("search_sets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/search_sets/1").should route_to("search_sets#destroy", :id => "1")
    end

  end
end
