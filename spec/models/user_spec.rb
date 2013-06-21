require 'spec_helper'

describe User do
  let (:user) { Fabricate.build(:user)}
  subject { user }

  it { should respond_to(:email) } 
  it { should respond_to(:fullname) } 
  it { should respond_to(:password_digest) }

  it { should be_valid }
  
  describe "when email is not present" do
    before { user.email = "" }
    it {should_not be_valid}
  end

  describe "when password_digest is not present" do 
    before { user.password_digest = "" }
    it { should_not be_valid }
  end
end 
