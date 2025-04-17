Rails.application.routes.draw do
  get 'diary_entries/index'
  get 'diary_entries/show'
  get 'diary_entries/new'
  get 'diary_entries/create'
  get 'diary_entries/edit'
  get 'diary_entries/update'
  get 'diary_entries/destroy'
  devise_for :users
  
  root 'top#index'

  get '/explanation', to: 'static_pages#explanation', as: 'explanation' # ①解説ページ
  get '/sample', to: 'static_pages#sample', as: 'sample'                # ②サンプルページ
  get '/login', to: 'users/sessions#new', as: 'login'                   # ③ログインページ
  get '/signup', to: 'users/registrations#new', as: 'signup'            # ④新規登録ページ

  root 'diary_entries#index'
  resources :diary_entries
end