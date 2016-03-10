require 'spec_helper'

# :sku, :short_name, :name, :description, :reference, :last_sale, :last_buy

describe Product do
  before do
    @product = Product.new(
                  sku: "4114-0",
                  short_name: "E-BOOK MOX-267 4GB 5.0 DIGI TCL",
                  name: "Tablet E-Book MOX-267 4Gb 5.0 Digital Teclado",
                  description: "Table E-Book de 4Gb 5.0 con Teclado Digital",
                  reference: nil,
                  is_active: true,
                  last_sale: 4.hours.ago,
                  last_buy: 3.days.ago)
  end

  subject { @product }

  it { should respond_to(:sku) }
  it { should respond_to(:short_name) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:reference) }
  it { should respond_to(:is_active) }
  it { should respond_to(:last_sale) }
  it { should respond_to(:last_buy) }

  it { should be_valid }


  describe "when SKU" do
    describe "is not present" do
      before { @product.sku = " " }
      it { should_not be_valid }
    end

    describe "is too short" do
      before { @product.sku = "a" }
      it { should_not be_valid }
    end

    describe "is too long" do
      before { @product.sku = "a" * 13 }
      it { should_not be_valid }
    end
  end



  describe "when short name" do
    describe "is not present" do
      before { @product.short_name = " " }
      it { should_not be_valid }
    end

    describe "is too short" do
      before { @product.short_name = "a" }
      it { should_not be_valid }
    end

    describe "is too long" do
      before { @product.short_name = "a" * 65 }
      it { should_not be_valid }
    end
  end



  describe "when name" do
    describe "is not present" do
      before { @product.name = " " }
      it { should_not be_valid }
    end

    describe "is too short" do
      before { @product.name = "a" }
      it { should_not be_valid }
    end

    describe "is too long" do
      before { @product.name = "a" * 256 }
      it { should_not be_valid }
    end
  end



  describe "when SKU is already taken" do
    before do
      product_with_same_sku = @product.dup
      product_with_same_sku.sku = @product.sku
      product_with_same_sku.save
    end

    it { should_not be_valid }
  end



  describe "when short name is already taken" do
    before do
      product_with_same_short_name = @product.dup
      product_with_same_short_name.short_name = @product.short_name
      product_with_same_short_name.save
    end

    it { should_not be_valid }
  end
end
