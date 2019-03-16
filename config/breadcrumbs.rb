crumb :root do
  link 'メルカリ', root_path
end

crumb :users do
  link 'マイページ', users_path
  parent :root
end

crumb :logout do
  link 'ログアウト', logout_users_path
  parent :users
end

crumb :user do
  link 'プロフィール', user_path(current_user)
  parent :users
end

crumb :indentification do
  link "本人情報の登録", indentification_users_path
  parent :users
end

crumb :payment_method do
  link "支払い方法", payment_method_users_path
  parent :users
end

crumb :card_registration do
  link "クレジットカード情報入力", card_registration_users_path
  parent :payment_method
end

crumb :item_show do
  link "正規品！COACH【コーチ】★★大きめ ミニシグネチャー ショルダーバッグ", item_path
  parent :root
end
# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
