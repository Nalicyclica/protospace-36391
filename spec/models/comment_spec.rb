require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  describe "コメント投稿機能" do
    it "情報が正しければ投稿できる" do
      expect(@comment).to be_valid
    end
    it "コメントが空だと投稿できない" do
      @comment.text = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Text can't be blank")
    end
  end
end