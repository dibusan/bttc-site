class Purchase < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :products

  def price
    (total/100.0).to_f
  end
end
