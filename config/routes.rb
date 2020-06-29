Rails.application.routes.draw do
  root "application#index"
  resources :product, only: [:add, :update, :get_by_id, :delete] do
    collection do
      post :add
      post :get_by_id
      post :delete
      post :update, path: "update"
    end
  end

  resources :store, only: [:add, :update, :get_by_id, :delete] do
    collection do
      post :add
      post :get_by_id
      post :delete
      post :update, path: "update"
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
