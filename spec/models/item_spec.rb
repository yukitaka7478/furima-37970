require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品できる場合' do
      it '必要な情報を適切に入力して「出品する」ボタンを押すと、商品情報がデータベースに保存される' do
        expect(@item).to be_valid
      end
    end
    context '出品できない場合' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it 'nameが空では出品できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("名前を入力してください")
      end
      it 'explanationが空では出品できない' do
        @item.explanation = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("説明を入力してください")
      end
      it 'category_idが空では出品できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーは---以外を選択してください")
      end
      it 'condition_idが空では出品できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態は---以外を選択してください")
      end
      it 'postage_idが空では出品できない' do
        @item.postage_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担は---以外を選択してください")
      end
      it 'prefecture_idが空では出品できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域は---以外を選択してください")
      end
      it 'sending_date_idが空では出品できない' do
        @item.sending_date_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数は---以外を選択してください")
      end
      it 'priceが空では出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end
      it 'priceが300円を下回ると出品できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は299より大きい値にしてください')
      end
      it 'priceが10000000円を超えると出品できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は10000000より小さい値にしてください')
      end
      it 'priceが半角数値でないと出品できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は数値で入力してください')
      end
      it 'userが存在しなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
