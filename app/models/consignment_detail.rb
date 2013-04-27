class ConsignmentDetail < ActiveRecord::Base
  attr_accessible :product_id, :quantity, :cost
  belongs_to :consignment
  
  validates :consignment_id, :presence => true, :unless => :nested
  validates :product_id, :presence => true, :unless => :nested
  validates :quantity, :numericality => { :greater_than => 0 }
  validates :cost, :numericality => { :greater_than_or_equal_to => 0 }

end