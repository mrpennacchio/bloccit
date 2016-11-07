require 'rails_helper'

RSpec.describe Advertisement, type: :model do
let(:advertisement) {Advertisement.create!}

  describe "attributes" do
    it "should have a title" do
      expect(advertisement).to respond_to(:title)
    end

    it "should have a body" do
      expect(advertisement).to respond_to(:body)
    end

    it "should have a price" do
      expect(advertisement).to respond_to(:price)
    end
  end
end
