require 'rails_helper'

RSpec.describe BuyDelivery, type: :model do
  before do
    item = FactoryBot.create(:item)
    another_user = FactoryBot.create(:user)
    @buy_delivery = FactoryBot.build(:buy_delivery, item_id: item.id, user_id: another_user.id)
  end

  describe '購入情報の保存' do
    context '保存できる場合' do
      it '全ての情報が入力されていれば保存できる' do
        expect(@buy_delivery).to be_valid
      end
      it 'building_nameが空でも保存できる' do
        @buy_delivery.building_name = nil
        expect(@buy_delivery).to be_valid
      end
    end
    context '保存できない場合' do
      it 'postage_codeが空では保存できない' do
        @buy_delivery.postage_code = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Postage code can't be blank")
      end
      it 'postage_codeが半角のハイフンを含んだ正しい形式でないと保存できない' do
        @buy_delivery.postage_code = '1234567'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include('Postage code is invalid. Include hyphen(-)')
      end
      it 'prefecture_idが空では保存できない' do
        @buy_delivery.prefecture_id = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'municipalityが空では保存できない' do
        @buy_delivery.municipality = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'house_numが空では保存できない' do
        @buy_delivery.house_num = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("House num can't be blank")
      end
      it 'telephone_numが空では保存できない' do
        @buy_delivery.telephone_num = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Telephone num can't be blank")
      end
      it 'telephone_numが10桁以上11桁以内の半角数値のみでなければ保存できない' do
        @buy_delivery.telephone_num = '010-1111-1111'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include('Telephone num is invalid. Not include hyphen(-)')
      end
      it 'userが存在しなければ保存できない' do
        @buy_delivery.user_id = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが存在しなければ保存できない' do
        @buy_delivery.item_id = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが存在しなければ保存できない' do
        @buy_delivery.token = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
