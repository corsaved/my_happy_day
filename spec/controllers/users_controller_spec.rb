require 'spec_helper'

describe UsersController do
  let(:user) { Fabricate(:user, fullname: "Alex", email: "alex@example.com", password: "q1w2e3") } 
  
  let(:valid_attributes) { { :email => "foo@mail.ru", :password => "foo" } }

  let(:valid_session) { { user_id: user.id } }

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new, {}, valid_session
      assigns(:user).should be_a_new(User)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      get :edit, {:id => user.to_param}, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, valid_attributes, valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}, valid_session
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the events calendar" do
        post :create, {:user => valid_attributes}, valid_session
        response.should redirect_to(:root)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {:user => { "email" => "invalid value" }}, valid_session
        assigns(:user).should be_a_new(User)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {:user => { "email" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        # Assuming there are no other users in the database, this
        # specifies that the User created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        User.any_instance.should_receive(:update_attributes).with({ "email" => "MyString" })
        put :update, {:id => user.to_param, :user => { "email" => "MyString" }}, valid_session
      end

      it "assigns the requested user as @user" do
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        assigns(:user).should eq(user)
      end

      it "redirects to the events calendar" do
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        response.should redirect_to(:root)
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => { "email" => "invalid value" }}, valid_session
        assigns(:user).should eq(user)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => { "email" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end
end
