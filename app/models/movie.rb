class Movie < ApplicationRecord
    belongs_to :user

    has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy
    has_and_belongs_to_many :categories
    has_one_attached :poster

    validates :title, presence: true, length: { maximum: 120 }
    validates :genre, presence: true, length: { maximum: 60 }
    validates :year,  presence: true,
                      numericality: {
                        only_integer: true,
                        greater_than: 1887,
                        less_than_or_equal_to: Time.current.year
                      }
    validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 },
                       allow_nil: true
    validates :director, length: { maximum: 120 }, allow_blank: true
    validates :duration, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
    validates :synopsis, length: { maximum: 3500 }, allow_blank: true
  end
