# class Users::SessionsController < Devise::SessionsController
#   # ログイン後のリダイレクト先
#   def after_sign_in_path_for(resource)
#     diary_entries_path 
#   end

#   # ログアウト後のリダイレクト先
#   def after_sign_out_path_for(resource_or_scope)
#     root_path # トップページへ
#   end
# end