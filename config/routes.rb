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

  resources :stock_item, only: [:add, :add_qty, :delete_qty, :get_by_id, :delete] do
    collection do
      post :add
      post :add_qty
      post :delete_qty
      post :delete
      post :get_by_id
      post :update, path: "update"
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
