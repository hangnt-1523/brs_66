class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  belongs_to :parent,  class_name: Comment.name, optional: true,
    foreign_key: :parent_id
  has_many :replies, class_name: Comment.name, dependent: :destroy,
    foreign_key: :parent_id

  validates :content, length: {minimum: Settings.comment.minimum,
    maximum: Settings.comment.maximum}

  acts_as_notifiable :users,
    targets: ->(comment, key) {
      ([comment.article.user] + comment.article.commented_users.to_a - [comment.user]).uniq
    },
  tracked: { only: [:new_reply], key: "comment.new_reply", send_later: false },
  notifiable_path: :article_notifiable_path

  def article_notifiable_path
    article_path(article)
  end

  def parent?
    self.parent.nil?
  end

  def new_reply
    self.replies.build book_id: self.book_id
  end
end
