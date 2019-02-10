class ApplicationDecorator < Draper::Decorator
  CURRENCY_PROPS = {
    unit: ' €',
    separator: '.',
    delimiter: ' ',
    precision: 2,
  }.freeze
end
