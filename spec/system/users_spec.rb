require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  describe "ユーザー管理機能の正常系" do 
    it "必要な情報を入力すると、新規登録できること" do
      visit root_path
      click_on("新規登録")
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password
      fill_in 'user_name', with: @user.name
      fill_in 'user_profile', with: @user.profile
      fill_in 'user_occupation', with: @user.occupation
      fill_in 'user_position', with: @user.position
      expect{ find('input[name="commit"]').click }.to change { User.count }.by(1)
      expect(current_path).to eq(root_path)
    end
    it "必要な情報を入力すると、ログインができること" do
      @user.save
      visit root_path
      click_on('ログイン')
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      expect(page).to have_content("#{@user.name}さん")
    end
    it "トップページから、ログアウトができること" do
      @user.save
      sign_in(@user)
      click_on("ログアウト")
      expect(current_path).to eq(root_path)
      expect(page).to have_content("ログイン")
    end
    it "ログイン状態では、ヘッダーに「ログアウト」「New Proto」のリンクが存在すること" do
      @user.save
      sign_in(@user)
      expect(page).to have_content("ログアウト")
      expect(page).to have_content("New Proto")
      expect(page).to have_content("#{@user.name}さん")
    end
    it "ログイン状態のユーザーであっても、他のユーザーのプロトタイプ編集ページのURLを直接入力して遷移しようとすると、トップページにリダイレクトされること" do
      @user.save
      sign_in(@user)
      @prototype = FactoryBot.create(:prototype)
      visit edit_prototype_path(@prototype)
      expect(current_path).to eq(prototypes_path)
    end
    it "ログイン状態のユーザーであっても、他のユーザーのプロトタイプ編集ページのURLを直接入力して遷移しようとすると、トップページにリダイレクトされること" do
      @user.save
      sign_in(@user)
      @prototype = FactoryBot.create(:prototype)
      visit edit_prototype_path(@prototype)
      expect(current_path).to eq(prototypes_path)
    end
  describe "ユーザー管理機能の異常系" do
    it "フォームに適切な値が入力されていない状態では、新規登録はできず、そのページに留まること" do
      visit root_path
      click_on("新規登録")
      expect{ find('input[name="commit"]').click }.to change { User.count }.by(0)
      expect(current_path).to eq(user_registration_path)
    end
    it "フォームに適切な値が入力されていない状態では、ログインはできず、そのページに留まること" do
        @user.save
        visit root_path
        click_on('ログイン')
        find('input[name="commit"]').click
        expect(current_path).to eq(user_session_path)
    end
  end
  # ログアウト状態では、ヘッダーに「新規登録」「ログイン」のリンクが存在すること
#   ログイン・ログアウトの状態に関わらず、各ページのユーザー名をクリックすると、ユーザーの詳細ページへ遷移すること
# ログイン・ログアウトの状態に関わらず、ユーザーの詳細ページには、そのユーザーの詳細情報（名前・プロフィール・所属・役職）と、そのユーザーが投稿したプロトタイプが表示されていること
# その他

# ログアウト状態のユーザーは、プロトタイプ新規投稿ページ・プロトタイプ編集ページに遷移しようとすると、ログインページにリダイレクトされること（ページはないが、削除機能にも同様の実装を行うこと）
# ログアウト状態のユーザーであっても、トップページ・プロトタイプ詳細ページ・ユーザー詳細ページ・ユーザー新規登録ページ・ログインページには遷移できること

end
