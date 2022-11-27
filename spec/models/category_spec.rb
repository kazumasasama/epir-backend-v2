require 'rails_helper'

RSpec.describe Category, type: :model do
  it "is valid with title" do
    category = Category.create(
      title: "Sパーツ"
    )
    expect(category.valid?).to eq true
  end

  it "is invalid without title" do
    category = Category.create(
      title: nil
    )
    expect(category.valid?).to eq false
  end

  it "is invalid with duplicated title" do
    Category.create(
      title: "Sパーツ"
    )
    category = Category.new(
      title: "Sパーツ"
    )
    category.valid?
    expect(category.errors[:title]).to include("has already been taken")
  end
end
