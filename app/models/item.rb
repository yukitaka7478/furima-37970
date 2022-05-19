class Item < ApplicationRecord
    validates :image, presence: true
    validates :name, presence: true
    validates :explanation, presence: true
    with_options numericality: { other_than: 1 , message: "can't be blank" } do
      validates :category_id
      validates :condition_id
      validates :postage_id
      validates :prefecture_id
      validates :sending_date_id
    end
    validates :price, presence: true, numericality: { greater_than: 299,less_than: 9999999 }
  

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :sending_date

  belongs_to :user
  #has_one :buy
  has_one_attached :image

end
