require "spec_helper"

describe EventsController do
  describe "routing" do

    it "routes to #index" do
      get("/events").should route_to("events#index")
    end

    it "routes to #new" do
      get("/events/new").should route_to("events#new")
    end

    it "routes to #edit" do
      get("/events/1/edit").should route_to("events#edit", :id => "1")
    end

    it "routes to #create" do
      post("/events").should route_to("events#create")
    end

    it "routes to #update" do
      put("/events/1").should route_to("events#update", :id => "1")
    end
  
  end
end
