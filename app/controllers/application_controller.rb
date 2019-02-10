class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :current_account

  private

  def current_account
    current_user.account
  end
end
