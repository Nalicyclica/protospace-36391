require 'rails_helper'

RSpec.describe "Comments", type: :system do
  before do
    @comment = FactoryBot.build(:comment)
    @comment.user.save
    @comment.prototype.save
  end
  describe "コメント投稿の正常系" do
    it "ログインしていればコメント投稿欄がある" do
      sign_in(@comment.user)
      click_on(@comment.prototype.title)
      expect(page).to have_content("コメント")
    end
    it "正しくフォームを入力すると、コメントが投稿できること" do
      sign_in(@comment.user)
      click_on(@comment.prototype.title)
      fill_in "comment_text", with: @comment.text
      expect{ click_on("送信する") }.to change{ Comment.count }.by(1)
      expect(current_path).to eq(prototype_path(@comment.prototype))
      expect(page).to have_content(@comment.text)
      expect(page).to have_selector(".comment_user")
      visit root_path
      expect(page).to have_no_content(@comment.text)
      expect(page).to have_no_selector(".comment_user")
    end
  end
  describe "コメント投稿の異常系" do
    it "ログインしていなければコメント投稿欄がない" do
      sign_in(@comment.user)
      click_on(@comment.prototype.title)
      expect(page).to have_no_content("コメント")
    end
    it "フォームを空のまま投稿しようとすると、投稿できずにそのページに留まること" do
      sign_in(@comment.user)
      click_on(@comment.prototype.title)
      fill_in "comment_text", with: ""
      expect{ click_on("送信する") }.to change{ Comment.count }.by(0)
      expect(current_path).to eq(prototype_comments_path(@comment.prototype))
      expect(page).to have_no_content(@comment.text)
    end
  end
end