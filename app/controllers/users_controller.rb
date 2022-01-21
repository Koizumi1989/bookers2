class UsersController < ApplicationController

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = Book.where(user: @user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id),notice: "Book was successfully updated."
    else
      render 'users/edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end
end

