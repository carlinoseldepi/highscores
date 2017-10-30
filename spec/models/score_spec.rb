require 'rails_helper'

# Test suite for the Score model
RSpec.describe Score, type: :model do
  # Association test
  # ensure an score record belongs to a single game record
  it { should belong_to(:game) }
  # Validation test
  # ensure columne player_email and score are present before saving
  it { should validate_presence_of(:player_email) }
  it { should validate_presence_of(:score) }
end