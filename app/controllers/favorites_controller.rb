class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = Favorite.new(book_id: book.id)
    favorite.user_id = current_user.id
    #上記2行はまとめて favorite = current_user.favorites.new(book_id: book.id) とも表記できる
    favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end
