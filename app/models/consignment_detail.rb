class ConsignmentDetail < ActiveRecord::Base
  attr_accessible :consignment_id, :product_id, :quantity, :cost
  belongs_to :consignment
  belongs_to :product
  validates_associated :consignment
  validates_associated :product
  validates :quantity, :numericality => { :greater_than => 0 }
  validates :cost, :numericality => { :greater_than_or_equal_to => 0 }
end