class AddAnswerCountToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :answers_count, :integer

    reversible { |dir| dir.up { data } }
  end

  def data
    execute <<-SQL.squish
      UPDATE questions
        SET answers_count = (SELECT count(1) from answers where answers.question_id = questions.id)
    SQL
  end
end
