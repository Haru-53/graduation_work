class Users::RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    dairy_entries_path(resource.id) # ← 自分のルーティングに合わせて変更
  end
end