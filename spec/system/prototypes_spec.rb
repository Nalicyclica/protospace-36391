require 'rails_helper'

RSpec.describe "Prototypes", type: :system do
  before do
    @prototype = FactoryBot.build(:prototype)
  end
  describe "プロトタイプ投稿の正常系" do
    it "正しく投稿するとトップページに遷移し、投稿した情報が表示されること" do
      binding.pry
      image_path = Rails.root.join('public/images/test.png')
      @prototype.user.save
      sign_in(@prototype.user)
      click_on("New Proto")
      fill_in 'prototype_title', with: @prototype.title
      fill_in 'prototype_catch_copy', with: @prototype.catch_copy
      fill_in 'prototype_concept', with: @prototype.concept
      attach_file('prototype[image]', image_path, make_visible: true)
      expect{ find('input[name="commit"]').click }.to change { Prototype.count }.by(1)
      expect(current_path).to eq(root_path)
    end
  end
  describe "プロトタイプ投稿の異常系" do
    it "投稿に必要な情報が入力されていない場合は、投稿できずにそのページに留まること、入力した情報は消えないこと" do
      @prototype.user.save
      sign_in(@prototype.user)
      click_on("New Proto")
      fill_in 'prototype_catch_copy', with: @prototype.catch_copy
      expect{ find('input[name="commit"]').click }.to change { Prototype.count }.by(0)
      expect(page).to have_content(@prototype.catch_copy)
      expect(current_path).to eq(prototypes_path)
    end
  end
end

# トップページに表示される投稿情報は、プロトタイプ毎に、画像・プロトタイプ名・キャッチコピー・投稿者の名前の、4つの情報について表示できること
# 画像が表示されており、画像がリンク切れなどになっていないこと（Herokuの仕様による画像のリンク切れは、要件未達に含まれない。Heroku上では一定時間経過すると画像が消える。）
# ログイン状態のユーザーだけが、投稿ページへ遷移できること

# ログイン・ログアウトの状態に関わらず、一覧表示されている画像およびプロトタイプ名をクリックすると、該当するプロトタイプの詳細ページへ遷移すること
# ログイン状態の投稿したユーザーだけに、「編集」「削除」のリンクが存在すること
# ログイン・ログアウトの状態に関わらず、プロダクトの情報（プロトタイプ名・投稿者・画像・キャッチコピー・コンセプト）が表示されていること
# 画像が表示されており、画像がリンク切れなどになっていないこと（Herokuの仕様による画像のリンク切れは、要件未達に含まれない。Heroku上では一定時間経過すると画像が消える。）
# プロトタイプ編集機能

# 投稿に必要な情報を入力すると、プロトタイプが編集できること
# 何も編集せずに更新をしても、画像無しのプロトタイプにならないこと
# ログイン状態のユーザーに限り、自身の投稿したプロトタイプの詳細ページから編集ボタンをクリックすると、編集ページへ遷移できること
# プロトタイプ情報について、すでに登録されている情報は、編集画面を開いた時点で表示されること（画像は表示されない状態で良い）
# 空の入力欄がある場合は、編集できずにそのページに留まること
# バリデーションによって編集ができず、そのページに留まった場合でも、入力済みの項目（画像以外）は消えないこと
# 正しく編集できた場合は、詳細ページへ遷移すること
# プロトタイプ削除機能

# ログイン状態のユーザーに限り、自身の投稿したプロトタイプの詳細ページから削除ボタンをクリックすると、プロトタイプを削除できること
# 削除が完了すると、トップページへ遷移すること
