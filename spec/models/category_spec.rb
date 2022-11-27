require 'rails_helper'

RSpec.describe Category, type: :model do

  describe "valid with:" do

    it "title" do
      category = Category.new(
        title: "Mパーツ"
      )
      expect(category.valid?).to eq true
    end

  end

  describe "invalid with:" do

    before do
      @category = Category.create(
        title: "Sパーツ"
      )
    end

    it "empty title" do
      @category.title = nil
      expect(@category.valid?).to eq false
    end
  
    it "duplicated title" do
      category = Category.new(
        title: "Sパーツ"
      )
      category.valid?
      expect(category.errors[:title]).to include("has already been taken")
    end

  end

end
