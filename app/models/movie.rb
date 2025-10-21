class Movie < ApplicationRecord
    belongs_to :user
    has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy

    validates :title, :genre, :year, :rating, presence: true
end