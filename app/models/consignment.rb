class Consignment < ActiveRecord::Base
  attr_accessible :supplier_id, :name, :status
  belongs_to :supplier
  has_many :consignment_details, :dependent => :destroy
  accepts_nested_attributes_for :consignment_details

  validates :name, presence: true, length: { minimum: 2, maximum: 255 }
  validates :status, :inclusion => { :in => [1, 6], :message => "%{value} no es un estado valido" }
  
end