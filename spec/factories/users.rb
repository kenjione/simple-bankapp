# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.disposable_email }
    password { FFaker::Internet.password }

    trait :rich do
      account { build :account }
    end
  end
end
