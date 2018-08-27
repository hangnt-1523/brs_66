class Book < ApplicationRecord
  include Filterable

  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :mark_books, dependent: :destroy
  has_many :order_detail, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  has_many :follows, dependent: :destroy, foreign_key: :follower_id
  has_many :passive_follows, class_name: Follow.name, foreign_key: :follower_id,
    dependent: :destroy
  has_many :follower_books, through: :passive_follows, source: :user

  accepts_nested_attributes_for :author_books

  validates :name, presence: true
  validates :description, presence: true
  validates :image, presence: true
  validates :publish_date, presence: true
  validates :price, presence: true
  validates :category_id, presence: true

  scope :by_id, -> book_id{where id: book_id}
  scope :order_by, ->{order created_at: :desc}
  scope :read_by, ->user{joins(:mark_books).where("mark_books.user_id = ? AND
    mark_books.status = ?", user.id,
    MarkBook.statuses[:reading]).order created_at: :desc}
  scope :favored_by, ->user{joins(:favorites).where("favorites.user_id = ?",
    user.id).order created_at: :desc}
  scope :favorites, (lambda do
    joins(:favorites).select(:id, :image, :name, :price, "count(books.id) as favorite_num")
      .group(:id).order("count(books.id) desc").limit(Settings.book.limit)
  end)
  scope :reading_max, (lambda do |status|
    joins(:mark_books).select(:id, :image, :name, :price,
    "count(books.id) as reading").where("mark_books.status": status)
    .group(:book_id).order("count(books.id) desc").limit(Settings.book.limit)
  end)
  scope :author_book_by, ->author{joins(:author_books)
    .where("author_books.author_id = ?", author.id).order created_at: :desc}
  scope :following_book, (lambda do|user|
    joins("LEFT JOIN follows ON follows.follower_id = books.id")
    .where("follows.type_follow = ? AND follows.user_id = ?",
    Follow.type_follows[:book], user.id).order(created_at: :desc)
  end)
  scope :favorite_by, ->{joins(:favorites).where("favorites.book_id = books.id")}
  scope :reading_by, ->{joins(:mark_books)
    .where("mark_books.book_id = books.id AND mark_books.status =?",
    MarkBook.statuses[:reading])}

  scope :rating_by, ->{joins("INNER JOIN rating_caches ON books.id = rating_caches.cacheable_id").order("rating_caches.avg desc")}

  ratyrate_rateable "rating"
  mount_uploader :image, ImageUploader
end
