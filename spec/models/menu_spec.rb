require 'rails_helper'

RSpec.describe Menu, type: :model do
  it "is valid with title and category_id" do
    menu = Menu.create(
      title: "両わき",
      category_id: 1
    )
    expect(menu.valid?).to eq true
  end

  it "is invalid without title" do
    menu = Menu.create(
      title: nil,
      duration: 30,
      price: 2900,
      description: "両わき",
      category_id: 1
    )
    menu.valid?
    expect(menu.errors[:title]).to include("can't be blank")
  end

  it "is invalid without category_id" do
    menu = Menu.create(
      title: "両わき",
      duration: 30,
      price: 2900,
      description: "両わき",
      category_id: nil
    )
    menu.valid?
    expect(menu.errors[:category_id]).to include("can't be blank")
  end

end
