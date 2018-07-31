class UsersController < ApplicationController
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, :logged_in_user, only: %i(edit update)

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".success"
      redirect_to root_path
    else
      flash[:danger] = t ".danger"
      render :new
    end
  end

  def edit; end

  def update
    if @user&.update_attributes user_params
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def likes
    @books = current_user.liked.page(params[:page]).per Settings.per_page
  end

  private

  def user_params
    params.require(:user).permit :username, :email, :password,
      :password_confirmation
  end
end
