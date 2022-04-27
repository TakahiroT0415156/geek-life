class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy

  validates :username, presence: true
  validates :postion, presence: true
  validates :region, presence: true
  validates :course, presence: true

  mount_uploader :image, ImageUploader
end
