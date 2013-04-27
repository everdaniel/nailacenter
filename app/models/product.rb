class Product < ActiveRecord::Base
  attr_accessible :sku, :short_name, :name, :description, :reference, :is_active, :last_sale, :last_buy

  has_many :stocks, dependent: :destroy

  before_save { |product| product.short_name = short_name.upcase }

  validates :sku, :uniqueness => true, presence: true, length: { minimum: 2, maximum: 12 }
  validates :short_name, :uniqueness => true, presence: true, length: { minimum: 2, maximum: 32 }
  validates :name, presence: true, length: { minimum: 2, maximum: 255 }

  def self.search(search)
    if search
      sku_condition = "%#{search}%"
      short_name_condition = "%#{search.upcase}%"
      name_condition = "%#{search}%"
      find(:all, :conditions => ['sku LIKE ? OR short_name LIKE ? OR name LIKE ?', sku_condition, short_name_condition, name_condition])
    else
      find(:all)
    end
  end
  
end