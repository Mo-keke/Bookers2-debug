class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @word = params[:word]
    @search = params[:search]
    @range = params[:range]

    if @range == "User"
      @users = User.looks(@search, @word)
    else
      @books = Book.looks(@search, @word)
    end
  end
end
