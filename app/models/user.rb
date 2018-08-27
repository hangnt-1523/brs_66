class User < ApplicationRecord
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :validatable, :trackables,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  attr_accessor :remember_token

  has_many :comments
  has_many :likes
  has_many :mark_books
  has_many :favorites
  has_many :orders
  has_many :liked, through: :likes, source: :book
  has_many :favorited, through: :favorites, source: :book
  has_many :follows

  has_many :active_follows, class_name: Follow.name, foreign_key: :user_id,
    dependent: :destroy
  has_many :passive_follows, class_name: Follow.name, foreign_key: :follower_id,
    dependent: :destroy
  has_many :followers, through: :passive_follows, source: :user
  has_many :following, through: :active_follows,  source: :follower
  has_many :following_author, through: :active_follows,  source: :follower
  has_many :following_book, through: :active_follows,  source: :follower

  ratyrate_rater

  mount_uploader :avatar, ImageUploader

  scope :following_by, ->following_by{where("follows.type_follow = ?", Follow.type_follows[:user]).order created_at: :desc}

  scope :follower_author, ->follower_author{where("follows.type_follow = ?", Follow.type_follows[:author]).order created_at: :desc}

  scope :follower_book, ->follower_book{where("follows.type_follow = ?", Follow.type_follows[:book]).order created_at: :desc}

  acts_as_target

  class << self
    def search key
      where("username LIKE ? OR email LIKE ? OR name LIKE ?", "%#{key}%", "%#{key}%", "%#{key}%")
    end

    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] &&
          session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end

    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
        user.image = auth.info.image
        user.skip_confirmation!
      end
    end
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

  def favorited? book
    favorited.include? book
  end

  def favorite book
    favorited << book
  end

  def current_favorite book
    favorites.find_by book_id: book.id
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  def following_author? author
    following_author.include? author
  end

  def following_book? book
    following_book.include? book
  end
end
