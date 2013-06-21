require "spec_helper"

describe "Date#next_week" do
  it { Date.today.next_week.should == Date.today + 7 }     
end
