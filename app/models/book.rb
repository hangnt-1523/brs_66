class Book < ApplicationRecord
  belongs_to :categories
  has_many :author_books
  has_many :rates
  has_many :comments
  has_many :likes
  has_many :mark_books
  has_many :order_detail
end
