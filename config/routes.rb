Rails.application.routes.draw do
  namespace :public do
    get 'searches/search'
  end
  namespace :public do
    get 'favorites/create'
    get 'favorites/destroy'
  end
  namespace :public do
    get 'post_comments/create'
    get 'post_comments/destroy'
  end
  namespace :public do
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
    get 'posts/update'
    get 'posts/destroy'
    get 'posts/index_your'
    get 'posts/show_your'
  end
  namespace :public do
    get 'relationships/create'
    get 'relationships/destroy'
    get 'relationships/followings'
    get 'relationships/followers'
  end
  namespace :public do
    get 'members/top'
    get 'members/index'
    get 'members/show'
    get 'members/show_your'
    get 'members/edit'
    get 'members/update'
    get 'members/check'
    get 'members/withdraw'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  devise_for :admins
  devise_for :members
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
