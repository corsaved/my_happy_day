require 'spec_helper'

describe EventsController do
  let(:user) { Fabricate(:user, fullname: "Alex", email: "alex@example.com", password: "q1w2e3") } 
 
  let(:valid_attributes) { { title: "The ruby conf", schedule: IceCube::Schedule.new.to_yaml, user: user } }
  
  let(:valid_form_attributes) { { :event_title => "The ruby conf",
                                  :event_start_date => Date.today.to_s,
                                  :event_end_date => "" } }

  let(:not_valid_form_attributes) { { :event_title => "",
                                      :event_start_date => Date.today.to_s,
                                      :event_end_date => "" } }
  
  let(:valid_session) { { user_id: user.id } }

  describe "GET index" do
    it "assigns all events as @events" do
     pending
      # event = Event.create! valid_attributes
      # get :index, {}, valid_session
      # assigns(:events_by_date).should has_value?([event])
    end
  end

  describe "GET new" do
    it "assigns a new event as @event" do
      get :new, {}, valid_session
      assigns(:event).should be_a_new(Event)
    end
  end

  describe "GET edit" do
    it "assigns the requested event as @event" do
      event = Event.create! valid_attributes
      get :edit, {:id => event.to_param}, valid_session
      assigns(:event).should eq(event)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Event" do
        expect {
          post :create, valid_form_attributes, valid_session
        }.to change(Event, :count).by(1)
      end

      it "assigns a newly created event as @event" do
        post :create, valid_form_attributes, valid_session
        assigns(:event).should be_a(Event)
        assigns(:event).should be_persisted
      end 

      it "redirects to the events calendar" do
        post :create, valid_form_attributes, valid_session
        response.should redirect_to(events_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved event as @event" do
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        post :create, not_valid_form_attributes, valid_session
        assigns(:event).should be_a_new(Event)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        post :create, not_valid_form_attributes, valid_session
        response.should render_template("new")
      end
    end

    describe "with recurring event flag" do
      it "creates a new event" do
         expect {
           post :create, { :event_title => "The ruby conf",
                           :event_start_date => Date.today.to_s,
                           :event_end_date => Date.tomorrow.to_s,
                           :recurring_event => "recurring_event",
                           :period => "daily" }, valid_session
        }.to change(Event, :count).by(1)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested event" do
        pending
        # event = Event.create! valid_attributes
        # # Assuming there are no other events in the database, this
        # # specifies that the Event created on the previous line
        # # receives the :update_attributes message with whatever params are
        # # submitted in the request.
        # Event.any_instance.should_receive(:update_attributes).with({ :title => "The ruby conf" })
        # put :update, {:id => event.to_param,
        #               :event_title => "The ruby conf",
        #               :event_start_date => Date.today.to_s,
        #               :event_end_date => "" }, valid_session
      end

      it "assigns the requested event as @event" do
        event = Event.create! valid_attributes
        put :update, {:id => event.to_param,
                      :event_title => "The ruby conf",
                      :event_start_date => Date.today.to_s,
                      :event_end_date => "" }, valid_session
        assigns(:event).should eq(event)
      end

      it "redirects to the events calendar" do
        event = Event.create! valid_attributes
        put :update, {:id => event.to_param,
                      :event_title => "The ruby conf",
                      :event_start_date => Date.today.to_s,
                      :event_end_date => "" }, valid_session
        response.should redirect_to(events_url)
      end
    end

    describe "with invalid params" do
      it "assigns the event as @event" do
        event = Event.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        put :update, {:id => event.to_param,
                      :event_title => "The ruby conf",
                      :event_start_date => Date.today.to_s,
                      :event_end_date => "" }, valid_session
        assigns(:event).should eq(event)
      end

      it "re-renders the 'edit' template" do
        event = Event.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        put :update, {:id => event.to_param,
                      :event_title => "The ruby conf",
                      :event_start_date => Date.today.to_s,
                      :event_end_date => "" }, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "Event " do
    
  end
end
