# frozen_string_literal: true

class Likeable < ApplicationRecord
  belongs_to :user
  belongs_to :answer
end
