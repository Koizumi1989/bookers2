class Book < ApplicationRecord
  belongs_to :user


  #book側からみるとユーザーが一人に決まるようになっている。
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  # uniqueness: true 重複させたくないときはこれを
end
