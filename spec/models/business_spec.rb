require 'rails_helper'

RSpec.describe Business, type: :model do
  it "is valid with name and email" do
    business = Business.create(
      name: "abc",
      email: "abc@shop.com"
    )
    expect(business.valid?).to eq true
  end

  it "is invalid without name" do
    business = Business.new(
      name: nil,
      email: "abc@shop.com"
    )
    business.valid?
    expect(business.errors[:name]).to include("can't be blank")
  end

  it "is invalid without email" do
    business = Business.new(
      name: "abc",
      email: nil
    )
    business.valid?
    expect(business.errors[:email]).to include("can't be blank")
  end
end
