require 'rails_helper'

RSpec.describe Prototype, type: :model do
  before do
    @prototype = FactoryBot.build(:prototype)
  end
  describe "プロトタイプ投稿機能" do
    it "必要な情報を入力すると、投稿ができること" do
      expect(@prototype).to be_valid
    end
    it "プロトタイプの名称が必須であること" do
      @prototype.title = ""
      @prototype.valid?
      expect(@prototype.errors.full_messages).to include("Title can't be blank")
    end
    it "キャッチコピーが必須であること" do
      @prototype.catch_copy = nil
      @prototype.valid?
      expect(@prototype.errors.full_messages).to include("Catch copy can't be blank")
    end
    it "コンセプトの情報が必須であること" do
      @prototype.concept = nil
      @prototype.valid?
      expect(@prototype.errors.full_messages).to include("Concept can't be blank")
    end
    it "画像は1枚必須であること(ActiveStorageを使用)" do
      @prototype.image = nil
      @prototype.valid?
      expect(@prototype.errors.full_messages).to include("Image can't be blank")
    end
  end
end