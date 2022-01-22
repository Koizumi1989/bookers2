class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: {minimum: 2,maximum: 20},uniqueness: true
  validates :introduction,length: {maximum: 50}

  has_many :books, dependent: :destroy
  # 1側：user N側：book
  #ユーザー側から見るとbook記事はいくつも持っているかたちになっている。
  #dependent: :destroyは特定のユーザーを消すと記事も消えるということ。
  has_one_attached :profile_image
  # has_one_attached :profile_imageという記述により、profile_imageという
  # 名前でActiveStorageでプロフィール画像を保存できるように設定しました。

  def get_profile_image(size)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize: size).processed
  end
end
