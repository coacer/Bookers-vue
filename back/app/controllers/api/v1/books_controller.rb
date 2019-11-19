class Api::V1::BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]

  def index
    books = Book.all.reverse
    render json: books
  end

  def show
    render json: @book
  end

  def create
    book = Book.new(book_params)
    book.user_id = params[:book][:user_id]
    if book.save
      render json: { status: 200, book: book }
    else
      render json: { status: 500, message: book.errors }
    end
  end

  def update
    if @book.update(book_params)
      render json: { status: 200, book: @book }
    else
      render json: { status: 500, message: @book.errors }
    end
  end

  def destroy
    @book.destroy
    render json: @book
  end

  private
  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
