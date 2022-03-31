# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  context 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:user_id) }
  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:question) }
    it { should have_many(:likeables) }
  end
end
