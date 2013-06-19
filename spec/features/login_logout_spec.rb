# coding: utf-8
require "spec_helper"

feature "Log in and log out" do
  # # As a registered user
  # # In order to get additional abilities
  # I want to log in to the site
  scenario "Registered user log in (success)" do
    Fabricate(:user, fullname: "Haul", email: "lofdur@gmail.com", password: "q1w2e3")

    visit "/login"

    fill_in "email", :with => "lofdur@gmail.com"
    fill_in "password", :with => "q1w2e3"
    click_button "Войти"

    page.should have_content "Logged in!"
  end

  scenario "Registered user log in (fail)" do
    Fabricate(:user, fullname: "Haul", email: "lofdur@gmail.com", password: "q1w2e3")

    visit "/login"

    fill_in "email", :with => "lofdur@gmail.com"
    fill_in "password", :with => "q1w2sdfsdf"
    click_button "Войти"

    page.should have_content "Invalid email or password"
  end

  scenario "Registered user log out" do
    Fabricate(:user, fullname: "Haul", email: "lofdur@gmail.com", password: "q1w2e3")

    visit "/logout"

    page.should have_content "Logged out"
  end
end
