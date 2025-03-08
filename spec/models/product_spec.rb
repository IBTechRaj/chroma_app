require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) { create(:category) }
  let(:product) { build(:product, category: category) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(product).to be_valid
    end

    it 'is not valid without a product_name' do
      product.product_name = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a brand_name' do
      product.brand_name = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a category' do
      product.category = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a description' do
      product.description = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a price' do
      product.price = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a selling_price' do
      product.selling_price = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a product_image' do
      product.product_image = nil
      expect(product).to_not be_valid
    end

    it 'is not valid if price is less than or equal to zero' do
      product.price = 0
      expect(product).to_not be_valid
    end

    it 'is not valid if selling_price is less than or equal to zero' do
      product.selling_price = 0
      expect(product).to_not be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:category) }
  end
end