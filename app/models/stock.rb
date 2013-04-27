class Stock < ActiveRecord::Base
  attr_accessible :cost, :price, :quantity
  belongs_to :product

  validates :cost, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validate :cost_is_less_than_total

  default_scope order: 'stocks.cost DESC'

  private
    def cost_is_less_than_total
      errors.add(:price, "debe ser mayor que el costo") if self.cost > self.price
    end
end
