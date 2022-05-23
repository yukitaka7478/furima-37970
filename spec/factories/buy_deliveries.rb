FactoryBot.define do
  factory :buy_delivery do
    postage_code    { '111-1111' }
    prefecture_id   { Faker::Number.between(from: 2, to: 48) }
    municipality    { 'テスト町' }
    house_num       { '123番地' }
    building_name   { 'テストハイツ101' }
    telephone_num   { Faker::Number.number(digits: 10) }
    token           { 'tok_abcdefghijk00000000000000000' }
  end
end
