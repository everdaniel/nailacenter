class Customer < ActiveRecord::Base
  attr_accessible :code, :company_name, :first_name, :last_name, :mobile, :phone
  before_save { |customer| customer.code = code.upcase }
  validates :code, :uniqueness => true, presence: true, length: { minimum: 2, maximum: 12 }

  def self.search(search)
    if search
      search_condition = "%#{search.downcase}%"
      find(
        :all,
        :conditions => [
          'LOWER(code) LIKE ? OR LOWER(company_name) LIKE ? OR LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?',
          search_condition,
          search_condition,
          search_condition,
          search_condition
        ]
      )
    else
      find(:all)
    end
  end
end