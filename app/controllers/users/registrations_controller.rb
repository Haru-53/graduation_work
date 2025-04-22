# class UsersController < ApplicationController
#   def new
#     @user = User.new
#   end

#   def create
#     @user = User.new(user_params)
    
#     if @user.save
#       session[:user_id] = @user.id
#       redirect_to new_diary_entry_path, notice: "ユーザー登録が完了しました"
#     else
#       flash.now[:alert] = "登録に失敗しました: #{@user.errors.full_messages.join(', ')}"
#       render :new
#     end
#   end

#   private
  
#   def user_params
#     params.require(:user).permit(:email, :password, :password_confirmation)
#   end
# end
