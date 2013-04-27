require 'spec_helper'

# :short_name, :name, :description

describe Supplier do
  before do
    @supplier = Supplier.new(
                  short_name: "NAVENET",
                  name: "Navenet CDE",
                  description: "Navenet de Ciudad del Este")
  end

  subject { @supplier }

  it { should respond_to(:short_name) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }

  it { should be_valid }

  describe "when short name" do
    describe "is not present" do
      before { @supplier.short_name = " " }
      it { should_not be_valid }
    end

    describe "is too short" do
      before { @supplier.short_name = "a" }
      it { should_not be_valid }
    end

    describe "is too long" do
      before { @supplier.short_name = "a" * 33 }
      it { should_not be_valid }
    end
  end



  describe "when name" do
    describe "is not present" do
      before { @supplier.name = " " }
      it { should_not be_valid }
    end

    describe "is too short" do
      before { @supplier.name = "a" }
      it { should_not be_valid }
    end

    describe "is too long" do
      before { @supplier.name = "a" * 256 }
      it { should_not be_valid }
    end
  end



  describe "when short name is already taken" do
    before do
      supplier_with_same_short_name = @supplier.dup
      supplier_with_same_short_name.short_name = @supplier.short_name
      supplier_with_same_short_name.save
    end
    
    it { should_not be_valid }
  end
end
