class FinancialTransactionDecorator < ApplicationDecorator
  delegate_all

  def created_at
    helpers.content_tag :span, class: 'time' do
      object.created_at.strftime("%m/%d/%y %T")
    end
  end

  def refferer
    object.refferer&.truncate(8, omission: '')
  end

  def type
    type = object.type
    h.content_tag :span, type, class: type
  end

  def amount
    return negative_amount if object.type == 'withdraw'
    h.content_tag :span, class: 'positive' do
      h.number_to_currency(object.amount, CURRENCY_PROPS.merge(format: '+%n%u'))
    end
  end

  private

  def negative_amount
    h.content_tag :span, class: 'negative' do
      h.number_to_currency(object.amount, CURRENCY_PROPS.merge(format: '-%n%u'))
    end
  end
end
