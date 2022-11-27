require 'rails_helper'

RSpec.describe Business, type: :model do

  describe "valid with:" do
    it "name and email" do
      business = Business.create(
        name: "abc",
        email: "abc@shop.com"
      )
      expect(business.valid?).to eq true
    end
  end

  describe "invalid with:" do
    before do
      @business = Business.new(
        name: "abc",
        email: "abc@shop.com"
      )
    end

    it "empty name" do
      @business.name = nil
      @business.email = "abc@shop.com"
      @business.valid?
      expect(@business.errors[:name]).to include("can't be blank")
    end
  
    it "empty email" do
      @business.name = "abc"
      @business.email = nil
      @business.valid?
      expect(@business.errors[:email]).to include("can't be blank")
    end
  end

end
