class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :movies, dependent: :nullify
  has_many :comments, dependent: :nullify

  def display_name
    email.to_s.split("@").first
  end
end
