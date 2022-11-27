require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Valid with:" do
    before do
      @new_user = User.new()
    end

    it "first_name, last_name, email and password" do
      @new_user.first_name = "First"
      @new_user.last_name = "Last"
      @new_user.email = "test@test.com"
      @new_user.password = "password"
      expect(@new_user).to be_valid
    end
  end

  describe "Invalid with:" do
    before do
      @new_user = User.new()
    end

    it "empty first_name" do
      @new_user.first_name = nil
      @new_user.valid?
      expect(@new_user.errors[:first_name]).to include("can't be blank")
    end
  
    it "empty last_name" do
      @new_user.last_name = nil
      @new_user.valid?
      expect(@new_user.errors[:last_name]).to include("can't be blank")
    end
  
    it "empty email" do
      @new_user.email = nil
      @new_user.valid?
      expect(@new_user.errors[:email]).to include("can't be blank")
    end

    it "duplicate email address" do
      User.create(
        first_name: "Joe",
        last_name:  "Tester",
        email:      "tester@example.com",
        password:   "password"
      )
      @new_user.first_name = "Joe"
      @new_user.last_name = "Tester"
      @new_user.email = "tester@example.com"
      @new_user.password = "password"
      @new_user.valid?
      expect(@new_user.errors[:email]).to include("has already been taken")
    end
  end

  describe "Modifying:" do
    before do
      @user = User.create(
        first_name: "Joe",
        last_name:  "Tester",
        email:      "tester@example.com",
        password:   "password"
      )
    end

    it "update" do
      @user.first_name = "Joe1"
      @user.last_name = "Tester1"
      @user.email = "tester1@example.com"
      @user.phone = "098-765-4321"
      @user.gender = "女性"
      @user.zip = 10010
      @user.state = "大阪府"
      @user.city = "大阪市"
      @user.address = "此花区"
      @user.note = "note1"
      @user.birthday = "1911-12-31"
      @user.status = "Admin"
      @user.line_id = "line_id_1"
      expect(@user.save).to eq true
    end

    it "delete" do
      @user.delete
      expect(@user.errors).to be_empty
    end
  end

  describe "Default value:" do
    before do
      @new_user = User.create(
        first_name: "Joe",
        last_name:  "Tester",
        email:      "tester@example.com",
        password:   "password"
      )
    end

    it "admin: false" do
      expect(@new_user.admin).to eq false
    end

    it "activated: false" do
      expect(@new_user.activated).to eq false
    end

  end

end
