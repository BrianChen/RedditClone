class User < ActiveRecord::Base

  validates :username, :password_digest, :session_token, presence: true
  validates :username, uniqueness: true
  validates :password, length: {minimum:6, allow_nil: true}

  has_many :subs
  
  after_initialize :ensure_session_token
  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user
      if user.is_password?(password)
        return user
      else
        return nil
      end
      nil
    end
    nil
  end

  def generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def reset_session_token
    self.session_token = generate_session_token
    self.save
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    pass = BCrypt::Password.new(self.password_digest)
    pass.is_password?(password)
  end

end
