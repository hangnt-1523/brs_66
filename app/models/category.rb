class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  scope :list_category, ->{select("id, title, description").
    order created_at: :desc}

  validates :title, presence: true,
    length: {maximum: Settings.category.title.length}
  validates :description, presence: true
end
