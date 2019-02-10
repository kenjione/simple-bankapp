class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  has_one :account, dependent: :destroy, inverse_of: :user
  has_many :financial_transactions, through: :account, dependent: :destroy

  after_create :create_account, unless: :account

  delegate :balance, to: :account
end
