class BooksController < ApplicationController
  before_action :load_book, except: %i(index new create)
  before_action :filtering_params, only: :index

  def index
    @books = Book.where(nil)
    filtering_params.each do |key, value|
      @books = @books.public_send(key, value) if value.present?
    end
    @categories = Category.all
    @authors = Author.all
  end

  def show
    @comments = @book.comments.all
    @comment = @book.comments.build
  end

  private

  def book_params
    params.require(:book).permit :name, :description, :image,
      :publish_date, :price, :category_id
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t ".danger"
    redirect_to books_path
  end

  def filtering_params
    params.slice :search_name, :search_category
  end
end
