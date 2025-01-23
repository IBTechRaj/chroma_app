# spec/models/cart_spec.rb
require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:cart) { FactoryBot.create(:cart, user: user) }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(cart).to be_valid
    end

    it "is invalid without a user" do
      cart.user = nil
      expect(cart).to_not be_valid
      expect(cart.errors[:user]).to include("can't be blank")
    end

    it "is invalid without a status" do
      cart.status = nil
      expect(cart).to_not be_valid
      expect(cart.errors[:status]).to include("can't be blank")
    end

    it "is invalid with an invalid status" do
      cart.status = 'invalid_status'
      expect(cart).to_not be_valid
      expect(cart.errors[:status]).to include("is not included in the list")
    end
  end

  describe "Associations" do
    it "belongs to a user" do
      expect(cart.user).to eq(user)
    end

    it "has many cart items" do
      expect(cart.cart_items).to eq([])
    end
  end

  describe "Methods" do
    let(:product1) { FactoryBot.create(:product, price: 50) }
    let(:product2) { FactoryBot.create(:product, price: 100) }

    before do
      cart.add_item(product1, 2) # Adds 2 of product1 (2 x 50)
      cart.add_item(product2, 1) # Adds 1 of product2 (1 x 100)
    end

    describe "#calculate_total" do
      it "calculates the total price of the cart" do
        expect(cart.calculate_total).to eq(200.0)
      end
    end

    describe "#add_item" do
      it "adds a product to the cart" do
        expect(cart.cart_items.size).to eq(2)
        expect(cart.cart_items.first.product).to eq(product1)
        expect(cart.cart_items.last.product).to eq(product2)
      end
    end
  end
end
