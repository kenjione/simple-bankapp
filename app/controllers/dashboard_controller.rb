class DashboardController < ApplicationController
  def index
    @transactions = current_user.financial_transactions
                                .order(created_at: :desc)
                                .decorate
  end
end
