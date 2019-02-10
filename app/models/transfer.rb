class Transfer
  include ActiveModel::Model

  attr_accessor\
    :amount,
    :receiver_id,
    :sender_id

  validates :amount, presence: true
  validates :receiver_id, presence: true
  validates :sender_id, presence: true

  validate :sender_receiver_uniqueness
  validate :sender_positive_balance

  def sender
    @sender ||= Account.find(sender_id)
  end

  def receiver
    @receiver ||= Account.find(receiver_id)
  end

  def call
    ActiveRecord::Base.transaction do
      return unless valid?
      sender.balance   -= amount
      receiver.balance += amount

      ref = SecureRandom.hex

      sender.financial_transactions.create!\
        type: 'withdraw',
        amount: amount,
        refferer: ref,
        description: "Transfer to #{receiver.email}"

      receiver.financial_transactions.create!\
        type: 'deposit',
        amount: amount,
        refferer: ref,
        description: "Transfer from #{sender.email}"

      sender.save!
      receiver.save!
    end
  rescue StandardError => err
    errors.add(:sender, :id, message: err.message)
  end

  private

  def sender_positive_balance
    return if (sender.balance - amount) >= 0
    errors.add(:sender, :ammount, message: 'has insufficient amount')
  end

  def sender_receiver_uniqueness
    return unless sender == receiver
    errors.add(:sender, :id, message: 'can not be equal receiver')
  end
end