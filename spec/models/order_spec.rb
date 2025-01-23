# spec/models/order_spec.rb
require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "Validations" do
    it "is valid with valid attributes" do
      order = FactoryBot.build(:order)
      expect(order).to be_valid
    end

    it "is invalid without a user" do
      order = FactoryBot.build(:order, user: nil)
      expect(order).to_not be_valid
      expect(order.errors[:user]).to include("must exist")
    end
    
    it "is invalid without a total_price" do
      order = FactoryBot.build(:order, total_price: nil)
      expect(order).to_not be_valid
      expect(order.errors[:total_price]).to include("can't be blank")
    end

    it "is invalid without a status" do
      order = FactoryBot.build(:order, status: nil)
      expect(order).to_not be_valid
      expect(order.errors[:status]).to include("can't be blank")
    end

    it "is invalid if status is not in the allowed list" do
      order = FactoryBot.build(:order, status: "invalid_status")
      expect(order).to_not be_valid
      expect(order.errors[:status]).to include("is not included in the list")
    end

    it "is invalid if total_price is not a number" do
      order = FactoryBot.build(:order, total_price: "invalid_total")
      expect(order).to_not be_valid
      expect(order.errors[:total_price]).to include("is not a number")
    end
  end

  describe "Associations" do
    it "belongs to a user" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe "Custom Methods" do
    describe "#calculate_total" do
      it "calculates the total price of the order based on order items" do
        order = FactoryBot.create(:order)
        FactoryBot.create(:order_item, order: order, price: 100, quantity: 2)
        FactoryBot.create(:order_item, order: order, price: 50, quantity: 1)
        expect(order.calculate_total).to eq(250)
      end
    end
  end
end
