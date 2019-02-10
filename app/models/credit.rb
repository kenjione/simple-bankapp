class Credit
  include ActiveModel::Model

  attr_accessor\
    :amount,
    :receiver_id

  validates :amount, presence: true
  validates :receiver_id, presence: true

  def receiver
    @receiver ||= Account.find(receiver_id)
  end

  def call
    ActiveRecord::Base.transaction do
      return unless valid?
      receiver.balance += amount
      receiver.financial_transactions.create!(type: 'credit', amount: amount, description: 'Credit by bank')
      receiver.save!
    end
  end
end