class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  belongs_to :parent,  class_name: Comment.name, optional: true,
    foreign_key: :parent_id
  has_many :replies, class_name: Comment.name, dependent: :destroy,
    foreign_key: :parent_id

  validates :content, length: {minimum: Settings.comment.minimum,
    maximum: Settings.comment.maximum}

  def parent?
    self.parent.nil?
  end

  def new_reply
    self.replies.build book_id: self.book_id
  end
end
