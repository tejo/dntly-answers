class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question, counter_cache: true
  has_many :likeables, dependent: :destroy
  has_many :likes, through: :likeables, source: :user

  validates :description, presence: true
  validates :user_id, presence: true
end
