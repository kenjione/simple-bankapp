module DashboardHelper
  def available_receivers
    Account.available_receivers_for(current_account)
  end
end
