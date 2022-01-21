class BooksController < ApplicationController

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @books = Book.all
    @book = Book.find(params[:id])
    @user = @book.user
    #アソシエーションでbookとuserは紐づいている。それに上の@book(com.books/idのこと)に紐づくuserを取り出せる。
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
  if @book.update(book_params)
    redirect_to book_path(@book.id), notice: "You have updated book successfully."
  else
    render 'books/edit'
  end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
  if @book.save
    redirect_to book_path(@book.id)
  else
    @user = current_user
    @books = Book.all
    render 'books/index'
  end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
end
