class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    comment = BookComment.new(book_comment_params)
    comment.user_id = current_user.id
    #上記2行はまとめて comment = current_user.book_comments.new(book_comment_params) とも表記
    comment.book_id = @book.id
    comment.save
    @book_comments = BookComment.where(book_id: @book.id)
    @book_comment = BookComment.new
  end

  def destroy
    @book = Book.find(params[:book_id])
    comment = BookComment.find(params[:id])
    comment.destroy
    @book_comments = BookComment.where(book_id: @book.id)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
