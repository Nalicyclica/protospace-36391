require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザーの新規登録" do
    it "全ての情報が正しければ、ユーザー登録できる" do
      expect(@user).to be_valid
    end
    it "ユーザーの新規登録には、メールアドレスが必須であること" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it "ユーザーの新規登録には、メールアドレスは一意性である" do
      @user2 = FactoryBot.create(:user)
      @user.email = @user2.email
      @user.valid?
      expect(@user.errors.full_messages).to include("Email has already been taken")
    end
    it "ユーザーの新規登録には、メールアドレスは@を含む必要があること" do
      @user.email = "hogehoge"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it "ユーザーの新規登録には、パスワードが必須であること" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it "ユーザーの新規登録には、パスワードは6文字以上であること" do
      @user.password = "xxxxx"
      @user.password_confirmation = "xxxxx"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it "ユーザーの新規登録には、パスワードは確認用を含めて2回入力すること" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "ユーザーの新規登録には、パスワードとパスワード確認用の値の一致が必須であること" do
      @user.password = "xxxxxx"
      @user.password_confirmation = "yyyyyy"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "ユーザーの新規登録には、ユーザー名が必須であること" do
      @user.name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end
    it "ユーザーの新規登録には、プロフィールが必須であること" do
      @user.profile = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Profile can't be blank")
    end
    it "ユーザーの新規登録には、所属が必須であること" do
      @user.occupation = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Occupation can't be blank")
    end
    it "ユーザーの新規登録には、役職が必須であること" do
      @user.position = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Position can't be blank")
    end
  end
end
