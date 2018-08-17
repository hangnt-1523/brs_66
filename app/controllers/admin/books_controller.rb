class Admin::BooksController < Admin::AdminController
  before_action :load_book, except: %i(index new create)
<<<<<<< 4c0401f0c8751e0bee660a51833783e2b6ad0b7c
  before_action :list_categories, only: :index

  def index
    @search_books = Book.ransack params[:q]
    @books = @search_books.result.includes(:category).order_by
                          .page(params[:page]).per Settings.book.per_page
  end

  def new
    @book = Book.new
    @book.author_books.build
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t ".success"
      redirect_to admin_books_path
    else
      flash[:danger] = t ".danger"
      render :new
    end
  end

  def edit; end

  def update
    if @book.update_attributes book_params
      flash[:success] = t ".success"
      redirect_to admin_books_path
    else
      flash[:danger] = t ".danger"
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    redirect_to admin_books_path
  end

  private

  def book_params
    params.require(:book).permit :name,:description, :image,
      :publish_date, :price, :category_id, author_ids:[], author_books_attributes:
      [:id, :book_id, :author_id]
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t ".danger"
    redirect_to admin_books_path
  end
end
