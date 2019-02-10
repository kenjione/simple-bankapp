class Account < ApplicationRecord
  belongs_to :user, inverse_of: :account

  has_many :financial_transactions, dependent: :destroy

  validates :user_id, presence: true
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  delegate :email, to: :user

  scope :available_receivers_for, -> (account) { where.not(id: account) }
end
