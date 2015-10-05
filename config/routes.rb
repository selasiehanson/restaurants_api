# == Route Map
#
#                  Prefix Verb   URI Pattern                                            Controller#Action
# api_v1_restaurant_menus GET    /api/v1/restaurants/:restaurant_id/menus(.:format)     api/v1/menus#index {:default=>"json"}
#                         POST   /api/v1/restaurants/:restaurant_id/menus(.:format)     api/v1/menus#create {:default=>"json"}
#  api_v1_restaurant_menu GET    /api/v1/restaurants/:restaurant_id/menus/:id(.:format) api/v1/menus#show {:default=>"json"}
#                         PATCH  /api/v1/restaurants/:restaurant_id/menus/:id(.:format) api/v1/menus#update {:default=>"json"}
#                         PUT    /api/v1/restaurants/:restaurant_id/menus/:id(.:format) api/v1/menus#update {:default=>"json"}
#                         DELETE /api/v1/restaurants/:restaurant_id/menus/:id(.:format) api/v1/menus#destroy {:default=>"json"}
#      api_v1_restaurants GET    /api/v1/restaurants(.:format)                          api/v1/restaurants#index {:default=>"json"}
#                         POST   /api/v1/restaurants(.:format)                          api/v1/restaurants#create {:default=>"json"}
#       api_v1_restaurant GET    /api/v1/restaurants/:id(.:format)                      api/v1/restaurants#show {:default=>"json"}
#                         PATCH  /api/v1/restaurants/:id(.:format)                      api/v1/restaurants#update {:default=>"json"}
#                         PUT    /api/v1/restaurants/:id(.:format)                      api/v1/restaurants#update {:default=>"json"}
#                         DELETE /api/v1/restaurants/:id(.:format)                      api/v1/restaurants#destroy {:default=>"json"}
#

Rails.application.routes.draw do
  
  namespace :api, {default: 'json'} do
    namespace :v1 do
      resources :restaurants, except: [:new, :edit ] do
        resources :menus, except: [:new, :edit ]
      end
    end
  end 

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
