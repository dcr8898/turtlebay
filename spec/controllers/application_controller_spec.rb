require 'rails_helper'

describe ApplicationController do
  let(:user) { FactoryGirl.create(:user)}

  describe '#current_user' do
    it 'returns the current user when user is logged in' do
      session[:user_id] = user.id
      expect(subject.current_user).to eq(user)
    end
    it 'returns nil when no user is logged in' do
      session.clear
      expect(subject.current_user).to be_nil
    end
  end

  describe '#logged_in?' do
    it 'returns true when user is logged in' do
      session[:user_id] = user.id
      expect(subject.logged_in?).to be_truthy
    end
    it 'returns false when no user is logged in' do
      session.clear
      expect(subject.logged_in?).to be_falsy
    end
  end

end
