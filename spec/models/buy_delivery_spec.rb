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
        expect(@buy_delivery.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'postage_codeが半角のハイフンを含んだ正しい形式でないと保存できない' do
        @buy_delivery.postage_code = '1234567'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include('郵便番号は無効です。ハイフン（ー）を含んでください。')
      end
      it 'prefecture_idが「---」では保存できない' do
        @buy_delivery.prefecture_id = '1'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("都道府県は---以外を選択してください")
      end
      it 'municipalityが空では保存できない' do
        @buy_delivery.municipality = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'house_numが空では保存できない' do
        @buy_delivery.house_num = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("番地を入力してください")
      end
      it 'telephone_numが空では保存できない' do
        @buy_delivery.telephone_num = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'telephone_numが9桁以下では保存できない' do
        @buy_delivery.telephone_num = '090090090'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("電話番号は10~11桁が有効です。ハイフン（ー）を含めないでください。")
      end
      it 'telephone_numが12桁以上では保存できない' do
        @buy_delivery.telephone_num = '090090090090'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("電話番号は10~11桁が有効です。ハイフン（ー）を含めないでください。")
      end
      it 'telephone_numが半角数字以外を含んでいると保存できない' do
        @buy_delivery.telephone_num = 'a010-1111-1111'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include('電話番号は10~11桁が有効です。ハイフン（ー）を含めないでください。')
      end
      it 'userが存在しなければ保存できない' do
        @buy_delivery.user_id = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Userを入力してください")
      end
      it 'itemが存在しなければ保存できない' do
        @buy_delivery.item_id = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Itemを入力してください")
      end
      it 'tokenが存在しなければ保存できない' do
        @buy_delivery.token = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end
