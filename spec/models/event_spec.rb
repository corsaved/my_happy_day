require 'spec_helper'

describe Event do
  let (:event) { Fabricate.build(:event)}
  subject { event }

  it { should respond_to(:title) } 
  it { should respond_to(:schedule) }  
  it { should respond_to(:init_schedule) } 

  it { should be_valid } 
  
  describe "when title is not present" do
    before { event.title = "" }
    it {should_not be_valid}
  end
  
  describe "when schedule is not present" do
    before { event.schedule = nil }
    it {should_not be_valid}
  end

  describe "#init_schedule" do
  end
end
