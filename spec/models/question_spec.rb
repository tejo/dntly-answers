# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:user_id) }
  end

  context 'associations' do
    it { should have_many(:answers) }
    it { should belong_to(:user) }
  end
end
