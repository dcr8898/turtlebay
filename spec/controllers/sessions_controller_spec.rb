require 'rails_helper'

describe SessionsController do
  let(:user) { FactoryGirl.create(:user) }

  describe "#new" do
    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "#create" do
    context "user provides correct credentials" do

      subject { post :create, session: { username: user.username, password: user.password }}

      it "sets a session cookie" do
        subject
        expect(session[:user_id]).to eq(user.id)
      end

      xit "redirects to the user's show route" do
        subject.should redirect_to user
      end
    end

    context "user provides incorrect credentials" do
      subject { post :create, session: { username: user.username, password: "abc123" }}

      it "does not set a cookie" do
        subject
        expect(session[:user_id]).to be_nil
      end

      it "renders the new template" do
        subject.should render_template("new")
      end

      xit "assigns flash message" do
        subject
        expect(flash.now[:alert]).not_to be_nil
      end
    end
  end

  describe "#destroy" do
    before (:each) do
      # set the session by login in
      post :create, session: { username: user.username, password: user.password }
    end

    it "should destroy session via delete request" do
      delete :destroy
      expect(session[:user_id]).to be_nil
    end
  end
end
