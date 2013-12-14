class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  before_create { generate_token(:auth_token) }
  validates :first_name, presence: true, length: { maximum: 20 }
  validates :last_name, presence: true, length: { maximum: 40 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # password must have one char, one num, and length between 6 and 12
  VALID_PASSWORD_REGEX = /\A.*(?=.{6,12})(?=.*\d)(?=.*[a-zA-Z]).*\z/
  validates :email, presence: true, 
		format: { with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, format: { with: VALID_PASSWORD_REGEX }

  # relations
  has_many :cemeteries, :foreign_key => "user_id"

  # methods

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver    
  end

  def send_account_confirmation
    generate_token(:account_confirmation_token)
    save!
    UserMailer.account_confirmation(self).deliver
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
