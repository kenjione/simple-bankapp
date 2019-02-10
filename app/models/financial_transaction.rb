class FinancialTransaction < ApplicationRecord
  self.inheritance_column = nil

  belongs_to :account

  delegate :email, to: :account, prefix: true
end
