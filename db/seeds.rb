# frozen_string_literal: true

user1 = User.new
user1.email = 'test@example.com'
user1.password = 'admin1'
user1.password_confirmation = 'admin1'
user1.avatar = '/site_assets/avatar.jpg'
user1.save!

user2 = User.new
user2.email = 'test@example2.com'
user2.password = 'admin1'
user2.password_confirmation = 'admin1'
user2.avatar = '/site_assets/avatar2.jpg'
user2.save!

user3 = User.new
user3.email = 'admin@admin.com'
user3.password = 'admin1'
user3.password_confirmation = 'admin1'
user3.avatar = '/site_assets/avatar3.jpg'
user3.save!

5.times do
  question = Question.new
  question.title = Faker::Quote.famous_last_words
  question.description = Faker::Lorem.paragraph
  question.user = user1
  question.save!

  answer = Answer.new
  answer.description = Faker::Lorem.paragraph
  answer.user = user2
  answer.question = question
  answer.likeables.build(user: user1)
  answer.save!

  answer = Answer.new
  answer.description = Faker::Lorem.paragraph
  answer.user = user1
  answer.question = question
  answer.likeables.build(user: user1)
  answer.save!
end

5.times do
  question = Question.new
  question.title = Faker::Quote.famous_last_words
  question.description = Faker::Lorem.paragraph
  question.user = user1
  question.save!
end

5.times do
  question = Question.new
  question.title = Faker::Quote.famous_last_words
  question.description = Faker::Lorem.paragraph
  question.user = user2
  question.save!
end
