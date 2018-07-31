class LikesController < ApplicationController
  before_action :logged_in_user, expect: :index

  def create
    @book = Book.find_by id: params[:book_id]
    current_user.like @book
    respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
  end

  def destroy
    @like = Like.find_by id: params[:id]
    @book = @like.book
    @like.destroy
    respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
  end
end
