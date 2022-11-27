require 'rails_helper'

RSpec.describe BusinessTime, type: :model do
  it "is valid with date, time and available" do
    bt = BusinessTime.new(
      date: "2022-01-01",
      time: "12:00:00",
      available: true
    )
    expect(bt.valid?).to eq true
  end
  
  it "is available set by default" do
    bt = BusinessTime.create(
      date: "2022-01-01",
      time: "12:00:00"
    )
    expect(bt.valid?).to eq true
  end

  it "is invalid without date" do
    bt = BusinessTime.create(
      date: nil,
      time: "12:00:00"
    )
    bt.valid?
    expect(bt.errors[:date]).to include("can't be blank")
  end

  it "is invalid without time" do
    bt = BusinessTime.create(
      date: "2022-01-01",
      time: nil
    )
    bt.valid?
    expect(bt.errors[:time]).to include("can't be blank")
  end

  it "is valid without time in Date/Time class" do
    bt = BusinessTime.new(
      date: Date.current,
      time: Time.zone.parse("10:00:00")
    )
    expect(bt.valid?).to eq true
  end

end
