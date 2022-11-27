require 'rails_helper'

RSpec.describe BusinessTime, type: :model do
  
  
  describe "valid with:" do

    before do
      @bt = BusinessTime.new()
    end
    
    it "date, time in string" do
      @bt.date = "2022-01-01"
      @bt.time = "12:00:00"
      expect(@bt.valid?).to eq true
    end

    it "date and time in Date/Time class" do
      @bt.date = Date.current
      @bt.time = Time.zone.parse("10:00:00")
      expect(@bt.valid?).to eq true
    end

  end

  describe "invalid with:" do

    before do
      @bt = BusinessTime.create(
        date: "2022-01-01",
        time: "12:00:00"
      )
    end
  
    it "empty date" do
      @bt.date = nil
      @bt.valid?
      expect(@bt.errors[:date]).to include("can't be blank")
    end
  
    it "empty time" do
      @bt.time = nil
      @bt.valid?
      expect(@bt.errors[:time]).to include("can't be blank")
    end

  end

end
