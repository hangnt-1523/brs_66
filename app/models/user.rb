class User < ApplicationRecord
  has_many :rates
  has_many :comments
  has_many :likes
  has_many :mark_books
  has_many :orders
  has_many :follows
end
