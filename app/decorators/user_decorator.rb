class UserDecorator < ApplicationDecorator
  delegate_all

  def balance
    balance = object.balance
    alert_class = case
                  when balance < 75 then 'danger'
                  when balance < 200 then 'warning'
                  else 'success'
                  end

    h.content_tag :div, class: "alert alert-#{alert_class}" do
      h.concat 'Current Balance: '
      h.concat h.number_to_currency(balance, CURRENCY_PROPS)
    end
  end
end
