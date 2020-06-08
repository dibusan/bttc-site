FactoryGirl.define do
  factory :purchase do
    user nil
    product nil
    paid 1
    fulfilled? false
    fulfillment "2020-06-03"
    notes "MyText"
  end
end
