# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "is valid with valid attributes" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it "is invalid without an email" do
      user = FactoryBot.build(:user, email: nil)
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a name" do
      user = FactoryBot.build(:user, name: nil)
      expect(user).to_not be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "is invalid if the email is not unique" do
      existing_user = FactoryBot.create(:user, email: "test@example.com")
      new_user = FactoryBot.build(:user, email: "test@example.com")
      expect(new_user).to_not be_valid
      expect(new_user.errors[:email]).to include("has already been taken")
    end

    it "is invalid without password" do
      user = FactoryBot.build(:user, password: nil)
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end
  end

  describe "Associations" do
    it "has many orders" do
      association = described_class.reflect_on_association(:orders)
      expect(association.macro).to eq(:has_many)
    end
  end

  # describe "Custom Methods" do
  #   describe "#full_name" do
  #     it "returns the full name of the user" do
  #       user = FactoryBot.build(:user, name: "John Doe")
  #       expect(user.full_name).to eq("John Doe")
  #     end
  #   end
  # end
end
