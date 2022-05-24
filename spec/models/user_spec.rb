require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nickname,email,password,password_confirmation,last_name,first_name,last_name_kana,first_name_kana,birth_dateが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'passwordが空では登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'emailの@がなければ登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it '重複したemailでは登録できない' do
        @user.save
        test_user = FactoryBot.build(:user, email: @user.email)
        test_user.valid?
        expect(test_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'passwordとpassword_confirmationが一致していないと登録できない' do
        @user.password = 'test123'
        @user.password_confirmation = 'test1234'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordは5文字以下では登録できない' do
        @user.password = 'test1'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが半角英数字混合でないと登録できない' do
        @user.password = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて設定してください")
      end
      it 'passwordは数字のみでは登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて設定してください")
      end
      it 'passwordは全角では登録できない' do
        @user.password = 'パスワード１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて設定してください")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("姓を入力してください")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("名を入力してください")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("姓カナを入力してください")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("名カナを入力してください")
      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ）以外では登録できない' do
        @user.last_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓全角文字を使用してください')
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）以外では登録できない' do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('名全角文字を使用してください')
      end
      it 'last_name_kanaが全角（カタカナ）以外では登録できない' do
        @user.last_name_kana = '名前'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓カナ全角カタカナを使用してください')
      end
      it 'first_name_kanaが全角（カタカナ）以外では登録できない' do
        @user.first_name_kana = '名字'
        @user.valid?
        expect(@user.errors.full_messages).to include('名カナ全角カタカナを使用してください')
      end
      it 'birth_dateが空では登録できない' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
