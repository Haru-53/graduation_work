Rails.application.routes.draw do
devise_for :users 
root 'top#index'
 get '/explanation', to: 'static_pages#explanation', as: 'explanation' # ①解説ページへのルーティング
 get '/sample', to: 'static_pages#sample', as: 'sample'         # ②sampleページへのルーティング
 get '/login', to: 'users/sessions#new', as: 'login'             # ③ログインページへのルーティング
 get '/signup', to: 'users/registrations#new', as: 'signup'      # ④新規登録ページへのルーティング

end