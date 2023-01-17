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

    # メンバーのルーティング
    get "members" => "members#index"
    get "members/my_page" => "members#show", as: "my_page"
    get "members/:nickname" => "members#show_your", as: "your_page"
    get "members/information/edit" => "members#edit", as: "members_edit"
    patch "members/update" => "members#update", as: "members_update"
    get "members/check" => "members#check", as: "members_check"
    patch "members/withdraw" => "members#withdraw", as: "members_withdraw"

    # リレーションシップのルーティング
    get "members/my_page/followings" => "relationships#followings", as: "members_followings"
    get "members/my_page/followers" => "relationships#followers", as: "members_followers"
    post "members/:id/relationships" => "relationships#create"
    delete "members/:id/relationships" => "relationships#destroy"

    resources :posts, only: [:create, :index, :show, :edit, :update, :destroy] do
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
