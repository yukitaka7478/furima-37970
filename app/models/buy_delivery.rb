class BuyDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postage_code, :prefecture_id, :municipality, :house_num, :building_name, :telephone_num,
                :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postage_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :municipality
    validates :house_num
    validates :telephone_num, format: { with: /\A[0-9]{10,11}\z/, message: 'is invalid. Not include hyphen(-)' }
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    buy = Buy.create(user_id: user_id, item_id: item_id)
    Delivery.create(postage_code: postage_code, prefecture_id: prefecture_id, municipality: municipality, house_num: house_num,
                    building_name: building_name, telephone_num: telephone_num, buy_id: buy.id)
  end
end
