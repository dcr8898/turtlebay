require 'rails_helper'

RSpec.describe Item, type: :model do

  context "validations" do
    it { expect(subject).to validate_presence_of :title }
    it { expect(subject).to validate_presence_of :start_time }
    it { expect(subject).to validate_presence_of :end_time }
  end

  context "associations" do
    it { expect(subject).to belong_to(:seller).class_name('User') }
    it { expect(subject).to belong_to(:buyer).class_name('User') }
    it { expect(subject).to have_many :bids }
  end

end
