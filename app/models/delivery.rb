class Delivery < ApplicationRecord
  belongs_to :buy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
