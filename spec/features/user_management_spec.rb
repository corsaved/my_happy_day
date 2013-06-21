# coding: utf-8
require "spec_helper"

feature "User management" do
  # As a calendar user
  # In order to 
  # I want to sign up, edit and delete my account
  scenario "When user sign up, create new user (success)" do
    visit "/users/new"

    fill_in "user_email", :with => "testuser@gmail.com"
    fill_in "user_fullname", :with => "HaulTheCrusader"
    fill_in "user_password", :with => "testpass"
    fill_in "user_password_confirmation", :with => "testpass"
    click_button "Save"

    page.should have_content "User was successfully created"
  end

  scenario "When user sign up, create new user (fails)" do
    visit "/users/new"

    fill_in "user_email", :with => "lof-+=ur@gmail.com"
    fill_in "user_fullname", :with => "HaulTheCrusader"
    click_button "Save"

    page.should have_no_content "User was successfully created"
  end

  scenario "Registered user edit his account (success)" do
    user = Fabricate(:user, fullname: "Alex", email: "alex@example.com", password: "q1w2e3") 

    visit "/login"

    fill_in "email", :with => "alex@example.com"
    fill_in "password", :with => "q1w2e3"
    click_button "Log in"

    visit edit_user_path(user)

    fill_in "user_fullname", :with => "HaulTheCrusader"
    click_button "Save"

    page.should have_content "User was successfully updated"
  end

  scenario "Registered user edit his account (fails)" do
    user = Fabricate(:user, fullname: "Alex", email: "alex@example.com", password: "q1w2e3") 

    visit "/login"

    fill_in "email", :with => "alex@example.com"
    fill_in "password", :with => "q1w2e3"
    click_button "Log in"

    visit edit_user_path(user)

    fill_in "user_email", :with => ""
    click_button "Save"

    page.should have_no_content "User was successfully updated"
  end

  scenario "Registered user destroy himself", :js => true do
    pending
  end

  scenario "Registered user can not edit account of the another registered user" do
    user_alex = Fabricate(:user, fullname: "Alex", email: "alex@example.com", password: "q1w2e3") 

    visit "/login"

    fill_in "email", :with => "alex@example.com"
    fill_in "password", :with => "q1w2e3"
    click_button "Log in"

    user_john = Fabricate(:user, fullname: "JonnyMnemonic", email: "neo@matrix.com", password_digest: "anystring") 

    visit edit_user_path(user_john)

    page.should have_content "You do not have permissions to this action"
  end
end
