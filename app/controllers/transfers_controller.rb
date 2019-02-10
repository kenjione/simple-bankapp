class TransfersController < ApplicationController
  def create
    @transfer = Transfer.new(assign_attributes)
    @transfer.call

    if @transfer.errors.messages.empty?
      redirect_to root_path, format: 'js'
    else
      render 'create'
    end
  end

  private

  def assign_attributes
    receiver_id = params.dig(:transfer, :receiver_id)
    amount      = params.dig(:transfer, :amount).to_f
    sender      = current_account

    { sender_id: sender.id, receiver_id: receiver_id, amount: amount }
  end
end
