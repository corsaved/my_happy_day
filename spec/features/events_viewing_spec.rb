require "spec_helper"

feature "Events viewing:" do
  # As a
  # In order to
  # I want to
  background do
    user_alex = Fabricate(:user, fullname: "Alex", email: "alex@example.com", password: "q1w2e3") 
    user_john = Fabricate(:user, fullname: "JonnyMnemonic", email: "neo@matrix.com", password_digest: "anystring") 
  
    Fabricate(:event, title: "ruby monks", schedule: IceCube::Schedule.new.to_yaml, user: user_alex) 
    Fabricate(:event, title: "ruby rogues", schedule: IceCube::Schedule.new.to_yaml, user: user_john) 
    Fabricate(:event, title: "no name podcast", schedule: IceCube::Schedule.new(Date.today + 30).to_yaml) 
    
    visit "/login"

    fill_in "email", :with => "alex@example.com"
    fill_in "password", :with => "q1w2e3"
    click_button "Log in"
    
    visit "/events"
  end
  
  scenario "registered user can see the list of all events" do
    page.should have_content "ruby monks"
    page.should have_content "ruby rogues" 
  end

  scenario "registered user can see only his events", :js => true do
    find("#current_user_events").click

    page.should have_content "ruby monks"
    page.should have_no_content "ruby rogues" 
  end

  scenario "registered user can not edit another user's event" do
    click_link "ruby rogues"

    page.should have_content "You do not have permissions to this action"     
  end

  scenario "not logged in user can not see calendar" do
    visit "/logout"
  
    visit "/events"

    page.should have_content "You do not have permissions to this action"     
  end

  scenario "render next month with next month events when user click on the '>' link" do
    click_link ">"

    page.should have_content "no name podcast"
  end
end 
