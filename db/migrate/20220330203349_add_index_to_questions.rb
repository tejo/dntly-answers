# frozen_string_literal: true

class AddIndexToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_index :questions, "to_tsvector('english', title)", using: :gin
    add_index :questions, "to_tsvector('english', description)", using: :gin
  end
end
