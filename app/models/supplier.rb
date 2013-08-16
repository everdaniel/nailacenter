class Supplier < ActiveRecord::Base
  attr_accessible :short_name, :name, :description
  has_many :consignments
  before_save { |supplier| supplier.short_name = short_name.upcase }
  validates :short_name, :uniqueness => true, presence: true, length: { minimum: 2, maximum: 32 }
  validates :name, presence: true, length: { minimum: 2, maximum: 255 }
  
  def self.search(search)
    if search
      search_condition = "%#{search.downcase}%"
      find(:all, :conditions => ['LOWER(short_name) LIKE ? OR LOWER(name) LIKE ?', search_condition, search_condition])
    else
      find(:all)
    end
  end
end