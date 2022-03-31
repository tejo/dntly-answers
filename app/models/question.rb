# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy, counter_cache: true
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :user_id, presence: true

  paginates_per 8
  include PgSearch::Model

  pg_search_scope :pg_search,
                  against: %i[title description],
                  using: {
                    tsearch: {
                      any_word: true
                    }
                  }

  def self.search(query)
    return all unless query.present?

    pg_search(query)
  end
end
