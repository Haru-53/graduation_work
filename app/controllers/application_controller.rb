class ApplicationController < ActionController::Base

  protected

  # ログイン後のリダイレクト先を指定
  def after_sign_in_path_for(resource)
    diary_entries_path
  end
end
