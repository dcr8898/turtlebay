require 'rails_helper'

RSpec.describe Bid, type: :model do

  before(:each) do
    @item = Item.create(seller_id: 1, title: "Howdy", start_time: DateTime.now - 1, end_time: DateTime.now + 1)
    @bid = Bid.create(amount: 5.00, bidder_id: 3, item_id: @item.id)
    @lower_bid = @item.bids.build(amount: 1.00, bidder_id: 4)
    @seller_bid = @item.bids.build(amount: 6.00, bidder_id: 1)
  end

  context "associations" do
    it { expect(subject).to belong_to(:bidder).class_name('User') }
    it { expect(subject).to belong_to :item }
  end

  context "validations" do

    xit { expect(subject).to validate_presence_of :amount }

    it "should be invalid with a lower bid" do
      expect(@lower_bid).to be_invalid
    end

    it "should add an appropriate error message when bid is lower" do
      @lower_bid.valid?
      expect( @lower_bid.errors[:invalid_bid]).to eq(["You must bid higher than previous bids."])
    end

    it "should be valid with a higher bid" do
      @higher_bid = @item.bids.build(amount: 6.00, bidder_id: 4)
      expect(@higher_bid).to be_valid
    end

    it "should validate whether a bidder id matches the item's seller id" do
      @seller_bid.valid?
      expect(@seller_bid).to be_invalid
    end

    it "should add an error message if bidder is the same as seller" do
      @seller_bid.valid?
      expect(@seller_bid.errors[:invalid_bid]).to eq(["You cannot bid on your own items."])
    end

  end

end


