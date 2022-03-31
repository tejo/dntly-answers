# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :likeables, dependent: :destroy
  validates :description, presence: true
  validates :user_id, presence: true
end
