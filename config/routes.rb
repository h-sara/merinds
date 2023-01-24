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
    get "members/information/edit" => "members#edit", as: "members_edit"
    patch "members/my_page" => "members#update"
    get "members/check" => "members#check", as: "members_check"
    patch "members/withdraw" => "members#withdraw", as: "members_withdraw"
    get "members/:nickname" => "members#show_your", as: "your_page"

    # リレーションシップのルーティング
    post "members/:member_id/relationships" => "relationships#create", as: "relationships_create"
    delete "members/:member_id/relationships" => "relationships#destroy", as: "relationships_destroy"
    get "members/my_page/followings" => "relationships#followings", as: "members_followings"
    get "members/my_page/followers" => "relationships#followers", as: "members_followers"

    # 投稿のルーティング
    get "posts/my_posts" => "posts#index", as: "my_posts"
    get "posts/my_posts/:id" => "posts#show", as: "my_post"
    get "posts/my_posts/:id/edit" => "posts#edit", as: "posts_edit"
    patch "posts/my_posts/:id" => "posts#update", as: "posts_update"
    get "posts" => "posts#index_your", as: "your_posts"
    get "posts/:id" => "posts#show_your", as: "your_post"
    post "posts" => "posts#create"
    delete "posts/my_posts/:id" => "posts#destroy", as: "posts_destroy"

    # いいねのルーティング
    get "/members/my_page/favorited_posts" => "favorites#index", as: "my_favorited_posts"
    post "posts/:post_id/favorites" => "favorites#create", as: "favorites_create"
    delete "posts/:post_id/favorites" => "favorites#destroy"

    # 投稿コメントのルーティング
    post "posts/:post_id/post_comments" => "post_comments#create", as: "post_comments_create"
    delete "posts/:post_id/post_comments/:id" => "post_comments#destroy", as: "post_comments_destroy"

    get "searches/search" => "searches#search"
  end
end
