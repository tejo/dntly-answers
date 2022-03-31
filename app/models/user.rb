# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :likeables, dependent: :destroy
  has_many :liked_answers, through: :likeables, source: :answer

  def like(answer)
    if liked_answers.include?(answer)
      liked_answers.destroy(answer)
    else
      liked_answers << answer
    end
  end

  def liked?(answer)
    liked_answers.include?(answer)
  end
end
