require 'rails_helper'

RSpec.describe Credit, type: :model do
  let(:user) { create :user }
  let(:credit) do
    build :credit, receiver_id: user.account.id, amount: 1000
  end

  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:receiver_id) }

  it 'Credit valid' do
    expect(credit).to be_valid
  end
end