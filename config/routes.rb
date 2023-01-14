Rails.application.routes.draw do

  # ゲスト用
  devise_scope :member do
    post 'members/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end


  # 管理者用（skipオプションを使用し不要なルーティングを削除している）
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get "top" => "homes#top", as: "top"
    resources :members, only: [:show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update] do
      resources :post_comments, only: [:show, :edit, :update]
    end
  end



  # 顧客用（skipオプションを使用し不要なルーティングを削除している）
  # URL /members/sign_in ...
  devise_for :members,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root "homes#top"
    get "about" => "homes#about"

    resource :members, only: [] do
      get "/", action: "index"
      get "my_page", action: "show"
      get "information/edit", action: "edit"
      patch "update", action: "update"
      get "check_withdrawal", action: "check"
      patch "withdraw_member", action: "withdraw"
      get ":nickname", action: "show_your"
      resource :relationships, only: [:create, :destroy] do
        member do
          get "followings"
          get "followers"
        end
      end
    end

    resources :posts, only: [:index, :show, :edit, :update, :destroy] do
      collection do
        get "index_your"
      end
      member do
        get "show_your"
        resource :favorites, only: [:create, :destroy]
        resources :post_comments, only: [:create, :destroy]
      end
    end

    get "searches/search" => "searches#search"
  end
end
