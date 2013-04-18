class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :username, :email, :password, :password_confirmation, :admin
  attr_accessor :updating_password
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :first_name, presence: true, length: { minimum: 2, maximum: 65 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 65 }
  validates :username, presence: true, length: { minimum: 2, maximum: 65 }, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6, maximum: 65 }, :if => :should_validate_password?
  validates :password_confirmation, presence: true, :if => :should_validate_password?

  def should_validate_password?
    updating_password || new_record?
  end

  private
  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end
end
