Rails.application.routes.draw do
  devise_for :users

  # 固定ページ系
  root 'top#index'  # ← 最初に表示するページ
  get '/explanation', to: 'static_pages#explanation', as: 'explanation'
  get '/sample', to: 'static_pages#sample', as: 'sample'
  get '/login', to: 'users/sessions#new', as: 'login'
  get '/signup', to: 'users/registrations#new', as: 'signup'

  # 日記のメイン機能
  resources :diary_entries do
    collection do
      get :calendar        # カレンダーページ
      get :summary         # 要約ページ
    end
  end

  # 幸福度関連
  resources :happiness_scores do
    collection do
      get :stats
    end
  end
end
