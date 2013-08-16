class Consignment < ActiveRecord::Base
  attr_accessible :supplier_id, :name, :status, :consignment_details_attributes
  belongs_to :supplier
  has_many :consignment_details, :dependent => :destroy
  delegate :name, :to => :supplier, :prefix => true
  accepts_nested_attributes_for :consignment_details, :allow_destroy => true, :reject_if => lambda { |c| c[:product_id].blank? }
  validates :supplier_id, presence: true
  validates :name, presence: true, length: { minimum: 2, maximum: 255 }
  validates :status, :inclusion => { :in => [1, 6], :message => "%{value} no es un estado valido" }
  default_scope order: "status ASC, created_at DESC"
end