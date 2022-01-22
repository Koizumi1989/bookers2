class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  #なぜアップデートを追加するかというかというと賢い人たちがurlからeditにいかずともupdate行える。

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
      redirect_to user_path(@user.id),notice: "You have updated user successfully."
    else
      render 'users/edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless @user == current_user
  end
end

