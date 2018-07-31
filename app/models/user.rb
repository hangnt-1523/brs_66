class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :rates
  has_many :comments
  has_many :likes
  has_many :mark_books
  has_many :orders
  has_many :follows
  has_many :liked, through: :likes, source: :book

  validates :username, presence: true,
   length: {maximum: Settings.user.name.length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
   length: {maximum: Settings.user.email.length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.user.password.length}, allow_nil: true

  has_secure_password

  class << self
    def digest string
      cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    @remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def current_user? user
    user == self
  end

  def liked? book
    liked.include? book
  end

  def like book
    liked << book
    end

  def unlike book
    liked.destroy book
  end

  def current_like book
    likes.find_by book_id: book.id
  end
end
