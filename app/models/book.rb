class Book < ApplicationRecord
  belongs_to :categories, optional: true
  has_many :author_books
  has_many :rates
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :mark_books
  has_many :order_detail

  scope :list_book, -> {select :id, :name, :image, :price,
    :created_at, :category_id}
end
