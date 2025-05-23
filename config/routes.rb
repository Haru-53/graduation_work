Rails.application.routes.draw do
  # Deviseのルーティング（コントローラを自作してる場合はcontrollersオプションもつける）
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # 固定ページ系
  root 'top#index'
  get '/explanation', to: 'static_pages#explanation', as: 'explanation'
  get '/try_it', to: 'static_pages#sample', as: 'try_it'

  # 日記のメイン機能
  resources :diary_entries do
    collection do
      get :calendar
      get :summary
    end
  end

  # 幸福度関連
  resources :happiness_scores do
    collection do
      get :stats
    end
  end
end
