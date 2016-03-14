require 'spec_helper'

# :code, :company_name, :first_name, :last_name, :phone, :mobile

describe Customer do
  before do
    @customer = Customer.new(
                  code: "EVER",
                  company_name: "NexusIT",
                  first_name: "Ever Daniel",
                  last_name: "Barreto Rojas",
                  phone: "071 209950",
                  mobile: "0985 127080")
  end

  subject { @customer }

  it { should respond_to(:code) }
  it { should respond_to(:company_name) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:phone) }
  it { should respond_to(:mobile) }

  it { should be_valid }

  describe "when code" do
    describe "is not present" do
      before { @customer.code = " " }
      it { should_not be_valid }
    end

    describe "is too short" do
      before { @customer.code = "a" }
      it { should_not be_valid }
    end

    describe "is too long" do
      before { @customer.code = "a" * 13 }
      it { should_not be_valid }
    end
  end



  describe "when code is already taken" do
    before do
      customer_with_same_code = @customer.dup
      customer_with_same_code.code = @customer.code
      customer_with_same_code.save
    end

    it { should_not be_valid }
  end
end
