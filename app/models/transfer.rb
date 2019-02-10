class Transfer
  include ActiveModel::Model

  attr_accessor\
    :amount,
    :receiver_id,
    :sender_id

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :receiver_id, presence: true
  validates :sender_id, presence: true

  validate :sender_receiver_uniqueness
  validate :sender_positive_balance

  def sender
    @sender ||= Account.find_by(id: sender_id)
  end

  def receiver
    @receiver ||= Account.find_by(id: receiver_id)
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
    return if (sender&.balance.to_f - amount.to_f) >= 0
    errors.add(:sender, :ammount, message: 'has insufficient amount')
  end

  def sender_receiver_uniqueness
    return unless sender_id == receiver_id
    errors.add(:sender, :id, message: 'can not be equal receiver')
  end
end