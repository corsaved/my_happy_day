require 'spec_helper'

describe Event do
  let (:event) { Fabricate.build(:event)}
  subject { event }

  it { should respond_to(:title) } 
  it { should respond_to(:date) } 
  it { should respond_to(:period) }

  it { should be_valid }
  
  describe "when title is not present" do
    before { event.title = "" }
    it {should_not be_valid}
  end
  
  describe "when date is not present" do
    before { event.date = nil }
    it {should_not be_valid}
  end

end
