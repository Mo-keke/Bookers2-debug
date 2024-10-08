class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comment, dependent: :destroy

  # あるユーザーがフォローしている人(フォロイー)の一覧を取得するアソシエーション
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed

  # あるユーザーがフォローされている人(フォロワー)の一覧を取得するアソシエーション
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.JPG'
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @users = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @users = User.where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      @users = User.where("name LIKE?", "%#{word}")
    elsif search == "partical_match"
      @users = User.where("name LIKE?", "%#{word}%")
    else
      @users = User.all
    end
  end
end