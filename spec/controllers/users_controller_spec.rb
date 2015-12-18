require 'rails_helper'

describe UsersController do
  let(:user) { FactoryGirl.create(:user) }

  describe "#new" do
    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end

    it "assigns @user" do
      get :new
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe "#create" do
    context "user provides valid attributes" do
      let(:valid_attributes) { FactoryGirl.attributes_for(:user) }

      subject { post :create, {user: valid_attributes} }

      it "should create a valid user" do
        subject
        expect(assigns(:user).valid?).to be true
      end

      it "has a 302 status code" do
        subject
        expect(response.status).to eq(302)
      end

      xit "should redirect to application root" do
        expect(subject).to redirect_to root_path
      end

      it "assign to session[:user_id]" do
        subject
        expect(session[:user_id]).to be_truthy
      end
    end

    context "user provides invalid attributes" do
      let(:invalid_attributes) { FactoryGirl.attributes_for(:user, password: "abc") }

      subject { post :create, {user: invalid_attributes} }

      it "should render the new template" do
        expect(subject).to render_template("new")
      end

      it "should not provide a session" do
        subject
        expect(session[:user_id]).to be nil
      end

      it "should create an invalid user" do
        subject
        expect(assigns(:user).valid?).to be false
      end

      it "has a 200 status code" do
        subject
        expect(response.status).to eq(200)
      end
    end
  end
end
