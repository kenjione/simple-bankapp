require 'rails_helper'

RSpec.describe Transfer, type: :model do
  let(:first_user) { create :user, :rich }
  let(:second_user) { create :user }
  let(:transfer) do
    build :transfer, sender_id: first_user.account.id,
                     receiver_id: second_user.account.id,
                     amount: 1000
  end

  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:sender_id) }
  it { should validate_presence_of(:receiver_id) }

  it 'Transfer valid' do
    expect(transfer).to be_valid
  end

  it 'Transfer is not valid - insufficient balance' do
    transfer.amount = 100_000
    expect(transfer).to be_invalid
    expect(transfer.errors.messages[:sender]).to eq(['has insufficient amount'])

    expect { transfer.call }.to change(transfer.sender.reload, :balance).by(0)
  end

  it 'Transfer is not valid - same user' do
    transfer.receiver_id = transfer.sender_id
    expect(transfer).to be_invalid
    expect(transfer.errors.messages[:sender]).to eq(['can not be equal receiver'])

    expect { transfer.call }.to change(transfer.sender.reload, :balance).by(0)
  end

  it 'Transfer successfully performed' do
    expect { transfer.call }.to\
     change(transfer.sender.reload, :balance).by(-1000).and\
     change(transfer.sender.financial_transactions, :count).by(1)
     change(transfer.receiver.financial_transactions, :count).by(1)
  end
end