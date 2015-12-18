require 'rails_helper'

RSpec.describe User, type: :model do

  context "validations" do
    it { expect(subject).to validate_presence_of :username }
    it { expect(subject).to validate_presence_of :email }
    it { expect(subject).to validate_presence_of :password }
    it { expect(subject).to have_secure_password }
  end

  context "associations" do
    it { expect(subject).to have_many(:items).with_foreign_key('seller_id') }
    it {
      expect(subject).to have_many(:purchases)
        .class_name('Item')
        .with_foreign_key('buyer_id')
    }
    it { expect(subject).to have_many(:bids).with_foreign_key('bidder_id') }
  end

end
